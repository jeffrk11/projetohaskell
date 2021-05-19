{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
import Text.Lucius
import Text.Julius

{-*
interpoladores: (shakesperean templates)

@ -> link
# -> string/text
^ -> Outro widget (html,css, javascript)
$ -> for, if e outros comandos
_ -> traducao i18n
*-}


getPage2R :: Handler Html
getPage2R = defaultLayout $ do
        [whamlet|
            <h1>
                pagina 2
        |]

getPage3R :: Handler Html
getPage3R = defaultLayout $ do
        [whamlet|
            <h1>
                pagina 3
        |]

menu :: Widget
menu = [whamlet|
            <ul>
                <li>
                    <a href=@{SobreR}>
                        pagina 1
                <li>
                    <a href=@{Page2R}>
                        pagina 2
                <li>
                    <a href=@{Page3R}>
                        pagina 3
        |]

--defaultlayout converte um widget (front) para handler(back)
getHomeR :: Handler Html
getHomeR = do
    defaultLayout $ do
        --javascript
        toWidgetHead $(juliusFile "templates/home.julius")
        --ccs/bootstrap.css
        addStylesheet (StaticR css_bootstrap_css)
        toWidgetHead $(luciusFile "templates/homer.lucius")
        $(whamletFile "templates/header.hamlet")
        $(whamletFile "templates/home.hamlet")
        


