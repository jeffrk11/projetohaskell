{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Nave where

import Import

formNave :: Form Nave
formNave = renderDivs $ Nave
    <$> areq textField (FieldSettings ""
                                    (Just "Nome da nave")
                                    (Just "nome_nave")
                                    Nothing
                                    [("class","formNome")]
                        ) Nothing
    <*> areq doubleField (FieldSettings ""
                                    (Just "Preco da nave")
                                    (Just "preco_nave")
                                    Nothing
                                    [("class","formPreco")]
                        ) Nothing
    <*> areq textareaField (FieldSettings ""
                                    (Just "Descricao da nave")
                                    (Just "desc_nave")
                                    Nothing
                                    [("class","formDesc")]
                        ) Nothing


-- /nave NaveR GET POST
getNaveR :: Handler Html
getNaveR = do
    (widget,_) <- generateFormPost formNave
    msg <- getMessage --(maybe text)
    defaultLayout $ [whamlet|
        $maybe mensa <- msg
            <h2>
                ^{mensa}

        <form action=@{NaveR} method=post>
            ^{widget}
            <input type="submit" value="Cadastrar">
    |]

postNaveR :: Handler Html
postNaveR = do
    ((result,_),_) <- runFormPost formNave
    case result of
        FormSuccess nave -> do
            runDB $ insert nave
            setMessage [shamlet|
                <div>
                    Nave inserida com sucesso
            |]
            redirect NaveR
        _ -> redirect  HomeR

-- /nave/catalogo/#NaveId CatalogoR GET

getCatalogoR :: NaveId -> Handler Html
getCatalogoR pid = do
    nave <- runDB $ get404 pid
    defaultLayout [whamlet|
        <div>
            <h1>
               Nome: #{naveNome nave}
            <h2>
               Preco:  #{navePreco nave}
            <h2>
                Desc: #{naveDescr nave}
    |]

-- /naves ListaNaveR GET

getListaNaveR :: Handler Html
getListaNaveR = do
    naves <- runDB $ selectList [] [Asc NaveNome]
    defaultLayout $(whamletFile "templates/nave/listar.hamlet")




-- /nave/#NaveId/apagar ApagarNaveR POST

postApagarNaveR :: NaveId -> Handler Html
postApagarNaveR pid = do
    runDB $ delete pid
    redirect ListaNaveR
