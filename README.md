# Server for Dubovozki app, written in swift framework Vapor

## Can be used for simple server-side firebase project

### Usage: 
1. ``` git clone https://github.com/ProbablyDead/DubovozkiServer ```
2. ``` cd DubovozkiServer ```
3. ``` open Package.swift ```
4. In Xcode open 'Edit scheme' -> 'Arguments' -> press plus button and add your own env variables, called ``` WEB_API_KEY ``` and ``` PRIVATE_KEY ``` 

> You can get them in ``` Project settings ``` of your firebase project
> WEB_API_KEY - General
> PRIVATE_KEY - Service account -> Generate new private key

5. In ``` configure.swift ``` file use your own ``` base path ``` and ``` email ```
6. Launch project
