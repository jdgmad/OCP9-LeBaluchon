# Le Baluchon
> Le Baluchon is an application for travellers. It offers services like currency conversion, weather report and text translation.
This app was realize from scratch during the iOS Developer training program of OpenclassRooms.

## Features
 
- Change the Currency with all the currencies of the world (API: Fixer.io)
- Translate a phrase from a language to another (API: Deepl)
- Check the weather in 2 differents cities at the same time (API: OpenWeatherMaps)

## Purpose of the project

The purpose of the project to get code competencies on :
- API calls with URLSessions
- API calls mocking for tests with URLProtocolFake
- PickerView
- SearchBar and TableView
- Generics

## Setup

To build the project you need to subscribe to the API providers Fixer.io, Deepl and OpenWeatherMaps and create a file APIKeys.swift
with the Keys  access :
```Swift
public struct ApiConfig {
    public static let fixerKey = "your API Key user"
    public static let openWheatherKey = "your API Key user"
    public static let deeplKey = "your API Key user"
}
```

## Code Architecture

This code use the MVC Architecture.


## Screenshots de l'app

![Screenshots de l'app Baluchon](Assets.xcassets/baluchon.png)

## Credits
José DE GUIGNE - 2021

