{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Calculos where

import Import

getSomaR :: Int -> Int -> Handler Html
getSomaR n1 n2 = do
    res <- return (show (n1+n2))
    defaultLayout $ do
        [whamlet|
            <h1>
                A Soma eh: #{res}
        |]