--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           System.Locale (TimeLocale(..))
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
    dateFieldWith ptTimeLocale "date" "%e de %B de %Y" `mappend`
    defaultContext

config :: Configuration
config = def {
        destinationDirectory = "../site"
    }


ptTimeLocale :: TimeLocale
ptTimeLocale =  TimeLocale {
  wDays  = [("domingo", "dom"), ("segunda-feira",    "seg"),
            ("terça-feira",    "ter"), ("quarta-feira", "qua"),
            ("quinta-feira",    "qui"), ("sexta-feira", "sex"),
            ("sábado",   "sab")],

  months = [("janeiro",   "jan"), ("fevereiro",  "fev"),
            ("março",      "mar"), ("abril",    "abr"),
            ("maio",       "mai"), ("junho",    "jun"),
            ("julho",  "jul"), ("agosto",    "ago"),
            ("setembro", "set"), ("outubro",  "out"),
            ("novembro",  "nov"), ("dezembro", "dez")],

  intervals = [ ("ano","anos")
              , ("mês", "meses")
              , ("dia","dias")
              , ("hora","horas")
              , ("min","mins")
              , ("seg","segs")
              , ("useg","usegs")
              ],
  amPm = (" da manhã", " da tarde"),
  dateTimeFmt = "%a %e %b %Y, %H:%M:%S %Z",
  dateFmt   = "%d-%m-%Y",
  timeFmt   = "%H:%M:%S",
  time12Fmt = "%I:%M:%S %p"
}
