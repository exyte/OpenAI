<a href="https://exyte.com/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/exyte/media/master/common/header-dark.png"><img src="https://raw.githubusercontent.com/exyte/media/master/common/header-light.png"></picture></a>

<a href="https://exyte.com/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/exyte/media/master/common/our-site-dark.png" width="80" height="16"><img src="https://raw.githubusercontent.com/exyte/media/master/common/our-site-light.png" width="80" height="16"></picture></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="https://twitter.com/exyteHQ"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/exyte/media/master/common/twitter-dark.png" width="74" height="16"><img src="https://raw.githubusercontent.com/exyte/media/master/common/twitter-light.png" width="74" height="16">
</picture></a> <a href="https://exyte.com/contacts"><picture><source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/exyte/media/master/common/get-in-touch-dark.png" width="128" height="24" align="right"><img src="https://raw.githubusercontent.com/exyte/media/master/common/get-in-touch-light.png" width="128" height="24" align="right"></picture></a>

<p><h1 align="left">OpenAI</h1></p>

<p><h4>This community-maintained library, written in Swift, provides an easy way to use the <a href="https://platform.openai.com/docs/api-reference/introduction">OpenAI REST API</a>.</h4></p>

![](https://img.shields.io/github/v/tag/exyte/OpenAIAssistants?label=Version)
[![SPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen.svg)](https://swiftpackageindex.com/exyte/OpenAIAssistants)
[![Cocoapods Compatible](https://img.shields.io/badge/cocoapods-Compatible-brightgreen.svg)](https://cocoapods.org/pods/OpenAIAssistants)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License: MIT](https://img.shields.io/badge/License-MIT-black.svg)](https://opensource.org/licenses/MIT)

## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

```swift
dependencies: [
    .package(url: "https://github.com/exyte/OpenAI")
]
```

### [CocoaPods](http://cocoapods.org)

To install `OpenAI`, simply add the following line to your Podfile:

```ruby
pod 'ExyteOpenAI'
```

### [Carthage](http://github.com/Carthage/Carthage)

To integrate `OpenAI` into your Xcode project using Carthage, specify it in your `Cartfile`

```ogdl
github "exyte/OpenAI"
```

## Requirements

* iOS 16+, tvOS 16+, macOS 13+, watchOS 8+
* Xcode 15+

# Assistants API usage

1. [Obtain](https://platform.openai.com/account/api-keys) your API key. Do not share this with others or expose it in any client-side code.
> ⚠️ OpenAI strongly recommends developers of client-side applications proxy requests through a separate backend service to keep their API key safe. API keys can access and manipulate customer billing, usage, and organizational data, so it's a significant risk to expose them.
2. Create a client instance.
```swift
let client = OpenAI(apiKey: "YOUR_API_KEY_HERE")
```
3. Create an Assistant by defining its instructions and model.
```swift
let assistantPayload = CreateAssistantPayload(model: .gpt_4o, name: "My Assistant", instructions: "Be funny")
client.createAssistant(from: assistantPayload) <...>
```
4. Create a Thread to start the conversation.
```swift
let threadPayload = CreateThreadPayload(messages: [...], metadata: [...])
client.createThread(from: threadPayload) <...>
```
5. Add Messages to the Thread from the user.
```swift
let messagePayload = CreateMessagePayload(role: .user, content: "Hello!")
client.createMessage(in: threadId, payload: messagePayload) <...>
```
6. Run the Assistant on the Thread to generate a response.
```swift
client.createRun(in: threadId, payload: CreateRunPayload(assistantId: assistantId)) <...>
```
7. Check the Run status until it is completed or failed.
```swift
client.retrieveRun(id: runId, from: threadId)
```
8. Retrieve the Messages from the Assistant.
```swift
let listPayload = ListPayload(after: lastMessageId)
client.listMessages(from: threadId, payload: listPayload) <...>
```

For more detailed information about OpenAI Assistants API usage, please refer to [platform.openai.com](https://platform.openai.com/docs/assistants/overview/agents) and our [Examples](#examples) section.

# Available endpoints

## Models

List and describe the various models available in the API. A list of models and their differences can be found on [platform.openai.com](https://platform.openai.com/docs/models).

### [List models](https://platform.openai.com/docs/api-reference/models/list)

```swift
listModels()
```

#### Returns `ObjectList<Model>`

### [Retreive model](https://platform.openai.com/docs/api-reference/models/retrieve)

```swift
retrieveModel(with: modelId)
```

#### Returns `Model`

### [Delete a fine-tuned model](https://platform.openai.com/docs/api-reference/models/delete)

```swift
deleteModel(with: modelId)
```

#### Returns `DeletionStatus`

## Files

Files are used to upload documents that can be used with features like Assistants.

### [Upload file](https://platform.openai.com/docs/api-reference/files/create)

```swift
uploadFile(payload: FilePayload(purpose: filePurpose, fileURL: fileURL))
```

#### Returns `File`

### [List files](https://platform.openai.com/docs/api-reference/files/list)

```swift
listFiles()
```

#### Returns `ObjectList<File>`

### [Retreive file](https://platform.openai.com/docs/api-reference/files/retrieve)

```swift
retrieveFile(id: fileId)
```

#### Returns `File`

### [Delete file](https://platform.openai.com/docs/api-reference/files/delete)

```swift
deleteFile(id: fileId)
```

#### Returns `DeletionStatus`

### [Retrieve file content](https://platform.openai.com/docs/api-reference/files/retrieve-contents)

```swift
retrieveFileContent(id: fileId, destinationURL: destinationURL)
```

#### Returns `URL`

## Assistants

Build assistants that can call models and use tools to perform tasks.

### [Create assistant](https://platform.openai.com/docs/api-reference/assistants/createAssistant)

```swift
createAssistant(from: CreateAssistantPayload(model: model, name: name, ...))
```

#### Returns `Assistant`

### [List assistants](https://platform.openai.com/docs/api-reference/assistants/listAssistants)

```swift
listAssistants(payload: ListPayload(limit: limit, ...))
```

#### Returns `ObjectList<Assistant>`

### [Retrieve assistant](https://platform.openai.com/docs/api-reference/assistants/getAssistant)

```swift
retrieveAssistant(id: assistantId)
```

#### Returns `Assistant`

### [Modify assistant](https://platform.openai.com/docs/api-reference/assistants/modifyAssistant)

```swift
modifyAssistant(id: assistandId, payload: CreateAssistantPayload(model: updatedModel, name: updatedName, ...))
```

#### Returns `Assistant`

### [Delete assistant](https://platform.openai.com/docs/api-reference/assistants/deleteAssistant)

```swift
deleteAssistant(id: assistantId)
```

#### Returns `DeletionStatus`

### [Create thread](https://platform.openai.com/docs/api-reference/threads/createThread)

```swift
createThread(
    from: CreateThreadPayload(
	messages: [CreateMessagePayload(role: .user, content: "Hello"), ...],
	metadata: ["key1": "value1", ...]
    )
)
```

#### Returns `Thread`

### [Retrieve thread](https://platform.openai.com/docs/api-reference/threads/getThread)

```swift
retrieveThread(id: threadId)
```

#### Returns `Thread`

### [Modify thread](https://platform.openai.com/docs/api-reference/threads/modifyThread)

```swift
modifyThread(id: threadId, payload: ModifyPayload(metadata: ["key1": "value1", ...]))
```

#### Returns `Thread`

### [Delete thread](https://platform.openai.com/docs/api-reference/threads/deleteThread)

```swift
deleteThread(id: threadId)
```

#### Returns `DeletionStatus`

### [Create message](https://platform.openai.com/docs/api-reference/messages/createMessage)

```swift
createMessage(in: threadId, payload: CreateMessagePayload(role: .user, content: "Hello"))
```

#### Returns `Message`

### [List messages](https://platform.openai.com/docs/api-reference/messages/listMessages)

```swift
listMessages(from: threadId, payload: ListPayload(limit: limit))
```

#### Returns `ObjectList<Message>`

### [Retrieve message](https://platform.openai.com/docs/api-reference/messages/getMessage)

```swift
retrieveMessage(id: messageId, from: threadId)
```

#### Returns `Message`

### [Modify message](https://platform.openai.com/docs/api-reference/messages/modifyMessage)

```swift
modifyMessage(id: messageId, from: threadId, payload: ModifyPayload(metadata: ["key1": "value1", ...]))
```

#### Returns `Message`

### [Create run](https://platform.openai.com/docs/api-reference/runs/createRun)

```swift
createRun(in: threadId, payload: CreateRunPayload(assistantId: assistantId, ...))
```

#### Returns `Run`

### [Create run with streaming](https://platform.openai.com/docs/api-reference/runs/createRun)

```swift
createStreamRun(in: threadId, payload: CreateStreamRunPayload(assistantId: assistantId))
```

#### Returns `StreamEvent` sequence

### [Create thread and run](https://platform.openai.com/docs/api-reference/runs/createThreadAndRun)

```swift
createThreadAndRun(
    from: CreateThreadAndRunPayload(
	assistantId: assistantId,
	thread: CreateThreadPayload(
	    messages: [CreateMessagePayload(role: .user, content: "Hello"), ...],
	    metadata: ["key1": "value1", ...]
	)
    )
)
```

#### Returns `Run`

### [List runs](https://platform.openai.com/docs/api-reference/runs/listRuns)

```swift
listRuns(from: threadId, payload: ListPayload(limit: limit, ...))
```

#### Returns `ObjectList<Run>`

### [Retrieve run](https://platform.openai.com/docs/api-reference/runs/getRun)

```swift
retrieveRun(id: runId, from: threadId)
```

#### Returns `Run`

### [Modify run](https://platform.openai.com/docs/api-reference/runs/modifyRun)

```swift
modifyRun(id: runId, from: threadId, payload: ModifyPayload(metadata: ["key1": "value1", ...]))
```

#### Returns `Run`

### [Cancel run](https://platform.openai.com/docs/api-reference/runs/cancelRun)

```swift
cancelRun(id: runId, from: threadId)
```

#### Returns `Run`

### [List run steps](https://platform.openai.com/docs/api-reference/run-steps/listRunSteps)

```swift
listRunSteps(from: runId, in: threadId, payload: ListPayload(limit: limit, ...))
```

#### Returns `ObjectList<RunStep>`

### [Retrieve run step](https://platform.openai.com/docs/api-reference/run-steps/getRunStep)

```swift
retrieveRunStep(id: runStepId, from: runId, in: threadId)
```

#### Returns `RunStep`

## Examples

To try the OpenAIAssistants examples:
- Clone the repo `https://github.com/exyte/OpenAI`
- Open OpenAIAssistantsExample/OpenAIAssistantsExample.xcodeproj
- Try it!

## Development Roadmap

- [x] Models
- [x] Files
- [x] Assistants
- [x] Run streaming
- [ ] Swift Concurrency support
- [ ] Chat
- [ ] Audio
- [ ] Images
- [ ] Moderations
- [ ] Fine-tuning
- [ ] Vector Store Files

## Our other open source SwiftUI libraries
[PopupView](https://github.com/exyte/PopupView) - Toasts and popups library    
[Grid](https://github.com/exyte/Grid) - The most powerful Grid container    
[ScalingHeaderScrollView](https://github.com/exyte/ScalingHeaderScrollView) - A scroll view with a sticky header which shrinks as you scroll    
[AnimatedTabBar](https://github.com/exyte/AnimatedTabBar) - A tabbar with a number of preset animations   
[MediaPicker](https://github.com/exyte/mediapicker) - Customizable media picker     
[Chat](https://github.com/exyte/chat) - Chat UI framework with fully customizable message cells, input view, and a built-in media picker  
[AnimatedGradient](https://github.com/exyte/AnimatedGradient) - Animated linear gradient     
[ConcentricOnboarding](https://github.com/exyte/ConcentricOnboarding) - Animated onboarding flow    
[FloatingButton](https://github.com/exyte/FloatingButton) - Floating button menu    
[ActivityIndicatorView](https://github.com/exyte/ActivityIndicatorView) - A number of animated loading indicators    
[ProgressIndicatorView](https://github.com/exyte/ProgressIndicatorView) - A number of animated progress indicators    
[FlagAndCountryCode](https://github.com/exyte/FlagAndCountryCode) - Phone codes and flags for every country    
[SVGView](https://github.com/exyte/SVGView) - SVG parser    
[LiquidSwipe](https://github.com/exyte/LiquidSwipe) - Liquid navigation animation    
