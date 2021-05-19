{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Sobre where

import Import
import Text.Lucius
import Text.Julius


getSobreR :: Handler Html
getSobreR = defaultLayout $ do
        --javascript
        toWidgetHead $(juliusFile "templates/home.julius")
        --ccs/bootstrap.css
        addStylesheet (StaticR css_bootstrap_css)
        toWidgetHead $(luciusFile "templates/homer.lucius")
        $(whamletFile "templates/header.hamlet")
        $(whamletFile "templates/sobre/sobre.hamlet")