# Test-Driven iOS Development with Swift 4 - Third Edition
This is the code repository for [Test-Driven iOS Development with Swift 4 - Third Edition](https://www.packtpub.com/application-development/test-driven-ios-development-swift-4-third-edition?utm_source=GitHub&utm_medium=repo&utm_campaign=9781788475709), published by [Packt](https://www.packtpub.com). It contains all the supporting project files necessary to work through the book from start to finish.

## About the Book

Test-driven development (TDD) is a proven way to find software bugs early. Writing tests before you code improves the structure and maintainability of your apps. Using TDD, in combination with Swift 4's improved syntax, means there is no longer any excuse for writing bad code.

This book will help you understand the process of TDD and how to apply it to your apps written in Swift.

Through practical, real-world examples, you’ll learn how to implement TDD in context. You will begin with an overview of the TDD workflow and then delve into unit-testing concepts and code cycles.

Finally, the book will guide you through the next steps to becoming a testing expert by discussing integration tests, Behavior Driven Development (BDD), open source testing frameworks, and UI Tests (introduced in Xcode 9).

## Instructions and Navigations
All of the code is organized into folders. Each folder starts with a number followed by the application name. For example, Chapter01.



The code will look like the following:
```

func test_NumberOfVowels_WhenPassedDominik_ReturnsThree() {
  let viewController = ViewController()
  let string = "Dominik"
  let numberOfVowels = viewController.numberOfVowels(in: string)
  XCTAssertEqual(numberOfVowels, 3, "should find 3 vowels in Dominik")
}

```

## Related Products
* [Developing iOS 11 Applications Using Swift 4 [Video]](https://www.packtpub.com/application-development/developing-ios-11-applications-using-swift-4-video?utm_source=GitHub&utm_medium=repo&utm_campaign=9781788393546)

* [Test-Driven iOS Development with Swift](https://www.packtpub.com/application-development/test-driven-ios-development-swift?utm_source=GitHub&utm_medium=repo&utm_campaign=9781785880735)

* [Learning iOS 8 Game Development Using Swift](https://www.packtpub.com/game-development/learning-ios-8-game-development-using-swift?utm_source=GitHub&utm_medium=repo&utm_campaign=9781784393557)
### Suggestions and Feedback
[Click here](https://docs.google.com/forms/d/e/1FAIpQLSe5qwunkGf6PUvzPirPDtuy1Du5Rlzew23UBp2S-P3wB-GcwQ/viewform) if you have any feedback or suggestions.





