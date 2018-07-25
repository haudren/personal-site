--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "index.html" $ do
        route   idRoute
        compile copyFileCompiler

    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "pdf/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "citations/*" $ do
        route idRoute
        compile copyFileCompiler

    match "pages/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "blog/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= saveSnapshot "content"
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    match "assets/*" $ do
        route idRoute
        compile copyFileCompiler

    create ["pages/blog.html"] $ do
        route idRoute
        compile $ do
            posts <- loadAllSnapshots "blog/*" "content"
            sorted <- recentFirst posts
            itemTemplate <- loadBody "templates/post.html"
            list <- applyTemplateList itemTemplate postCtx sorted
            makeItem list
                >>= loadAndApplyTemplate "templates/default.html" (blogCtx list)
                >>= relativizeUrls

    match "templates/*" $ compile templateCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext

blogCtx :: String -> Context String
blogCtx list =
    constField "title" "Blog" `mappend`
    constField "body" list `mappend`
    defaultContext
