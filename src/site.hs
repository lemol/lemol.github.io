--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll
import           Data.Default


--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith config $ do
    match "img/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "js/*" $ do
        route idRoute
	compile copyFileCompiler

    match "font/*" $ do
	route idRoute
	compile copyFileCompiler

    match (fromList ["about.markdown", "contact.markdown"]) $ do
        route   $ setExtension "html"
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let ctx =
		    listField "posts" postCtx (return posts) `mappend`
		    defaultContext

	    comp <- pandocCompiler
            temp <- loadAndApplyTemplate "templates/main.html" ctx comp
                    >>= loadAndApplyTemplate "templates/default.html" ctx
            relativizeUrls temp

    match "posts/*" $ do
        route $ setExtension "html"
        compile $
	    pandocCompiler
                >>= loadAndApplyTemplate "templates/post.html"    postCtx
                >>= loadAndApplyTemplate "templates/default.html" postCtx
                >>= relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Archives"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls


    create ["index.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Home"                `mappend`
                    defaultContext

            makeItem ""
                {->>= applyAsTemplate indexCtx-}
                >>= loadAndApplyTemplate "templates/index.html" indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    {-match "templates/default.html" $ compile $ do -}
        {-posts <- recentFirst =<< loadAll "posts/*"-}
	{-let ctx = listField "posts" postCtx (return posts) `mappend` postCtx-}
	{-pandocCompiler-}
                {->>= loadAndApplyTemplate "templates/default.html" ctx-}
                {->>= relativizeUrls-}
        {-templateCompiler-}

    match "templates/*" $ compile templateCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext

config :: Configuration
config = def {
        destinationDirectory = "../site"
    }
