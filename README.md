# dva_flutter

Combine BloC and dva_dart together

## Getting Started

1. Read `Concept` first.
2. Wait for example, please.

This project is a starting point for a Dart
[package](https://flutter.io/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our
[online documentation](https://flutter.io/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Concept

There are a lot of resolutions for flutter's state managing.

`redux_dart` and `BloC` are both great libs to start with.

`redux_dart` is mainly for react developers, but it's not easy to configure, especially they are not javascript developers originally.

`Bloc` is using `rxdart` and using the `Stream/Sink` related solotions, which is recommended by Flutter official.

However, when it comes to real project development, things are getting hard.

When you are trying to make a side-effect call to server or simply trying to get states from other operations,

both `Bloc` and `redux_dart` are hard to use.

Luckily, in `javascript/react` world, we have `DvaJS` to ease the pain, which combines the `redux`,`redux_saga` together, only 8 apis to remember and easy to configure your app.

It comes to an idea, why we try combine the `Bloc` and `DvaJS` together, we use `Stream/Sink` and `rxdart` as the state listener, and use `Reducer`,`ActionDispatcher` and `SideEffect` as the data model configuration.

So we had make `dva_dart` and `dva_flutter` to make things happen.

It might work in a way.

So we use several parts to solve the problem.

- Provider -- `dva_flutter`
- Connector -- `dva_flutter`
- DvaModel -- `dva_dart`
- DvaStore -- `dva_dart`
- DvaEffect (PutEffect, CallEffect) -- `dva_dart`
- DvaState -- `dva_dart`
- Action -- `dva_dart`
- Payload -- `dva_dart`
