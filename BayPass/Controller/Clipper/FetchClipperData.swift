//
//  FetchClipperData.swift
//  BayPass
//
//  Created by Tim Roesner on 3/28/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Alamofire
import SwiftSoup
import UIKit

extension SignInViewController {
    func fetchClipperData(email: String, password: String, completion: @escaping ([ClipperCard]?) -> Void) {
        Alamofire.request("https://www.clippercard.com/ClipperCard/loginFrame.jsf", method: .get, parameters: nil).responseString(completionHandler: { response in
            do {
                let doc: Document = try SwiftSoup.parse(response.value ?? "")
                let inputs: Elements = try doc.select("input")
                for input in inputs {
                    let inputName = try input.attr("name")
                    if inputName.contains("ViewState") {
                        if let viewState = try? input.attr("value") {
                            self.login(viewState: viewState, email: email, password: password, completion: {
                                completion($0)
                            })
                        }
                    }
                }
            } catch {
                print("Error parsing HTML")
                completion(nil)
            }
        })
    }

    private func login(viewState: String, email: String, password: String, completion: @escaping ([ClipperCard]?) -> Void) {
        let headers = [
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0.3 Safari/605.1.15",
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
            "Accept": "*/*",
            "Referer": "https://www.clippercard.com/ClipperCard/loginFrame.jsf",
            "Faces-Request": "partial-ajax",
            "cache-control": "no-cache",
        ]

        let postData = [
            "j_idt13": "j_idt13",
            "j_idt13:username": email,
            "j_idt13:password": password,
            "javax.faces.behavior.event": "action",
            "javax.faces.partial.ajax": "true",
            "javax.faces.partial.execute": "j_idt13:submitLogin j_idt13:username j_idt13:password",
            "javax.faces.partial.render": "j_idt13:err",
            "javax.faces.source": "j_idt13:submitLogin",
            "javax.faces.ViewState": viewState,
        ]

        Alamofire.request("https://www.clippercard.com/ClipperCard/loginFrame.jsf", method: .post, parameters: postData, encoding: URLEncoding.httpBody, headers: headers).responseString { response in
            do {
                let doc: Document = try SwiftSoup.parse(response.value ?? "")
                let form: Element? = try doc.select("form").first()
                if try form?.attr("action") == "/ClipperCard/loginFrame.jsf" {
                    completion(nil)
                } else {
                    completion(self.parseCard(from: doc))
                }
            } catch {
                print("Error parsing HTML")
                completion(nil)
            }
        }
    }

    func parseCard(from doc: Document) -> [ClipperCard]? {
        var result = [ClipperCard]()
        let cardSections = (try? doc.select("div").filter { try $0.attr("class").contains("greyBox") }) ?? []
        for section in cardSections {
            if let dividers = try? section.select("div").array() {
                var cardNumber: Int = 0
                var type: String = ""
                var isActive: Bool = false
                var products: String = ""
                var cashValue: Double = 0.0

                for (index, div) in dividers.enumerated() {
                    let text = (try? div.text()) ?? ""
                    let nextText = (try? dividers[safe: index + 1]?.text() ?? "") ?? ""

                    if text == "Serial Number:" {
                        cardNumber = Int(nextText) ?? 0
                    } else if text == "Type:" {
                        type = nextText
                    } else if text == "Status:" {
                        isActive = (nextText == "Active")
                    } else if text == "Products on Card:" {
                        products = nextText
                    } else if text == "Cash value:" {
                        cashValue = Double(nextText.replacingOccurrences(of: "$", with: "")) ?? 0.0
                    }
                }

                if isActive {
                    _ = type
                    _ = products
                    let newCard = ClipperCard(number: cardNumber, cashValue: cashValue, passes: [])
                    result.append(newCard)
                }
            }
        }
        return result.isEmpty ? nil : result
    }
}
