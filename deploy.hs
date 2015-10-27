#! /usr/bin/env stack
-- stack --verbosity warn --system-ghc runghc --package shake
-- vim: set filetype=haskell :

import Development.Shake hiding (doesFileExist)
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util
import System.Directory
import Control.Monad
import System.Posix.Files
import System.Environment

main :: IO ()
main = do

    home <- liftIO getHomeDirectory
    progName <- getProgName
    progNamePath <- makeAbsolute progName
    let exPath = takeDirectory progNamePath -- this doesn't work outside the dotfiles directory for runghc.

    let lnFile out = do
            let inPath = exPath </> dropWhile ('.'==) (takeFileName out)
            outAbs <- makeAbsolute out
            putStrLn $ "Link " ++ inPath ++ " " ++ outAbs
            checkFile inPath outAbs
            createSymbolicLink inPath outAbs

    shakeArgs shakeOptions $ do

    want $ (home </>) <$>
        [ ".vimrc"
        , ".gvimrc"
        , ".bashrc"
        , ".ghci"
        , ".gitconfig"
        , ".local/bin/pophoogle"
        ]

    -- (home </>) <$> [".bashrc", ".vimrc", ".gvimrc"] |%> \ out -> do
    --     alwaysRerun
    --     putNormal $ "Append to " ++ out
    --     localPath <- liftIO $ makeAbsolute $ dropWhile ('.'==) $ takeFileName out
    --     liftIO $ appendFile out $ "\nsource " ++ localPath ++ "\n"

    home </> ".bashrc" %> \ out -> do
        alwaysRerun
        putNormal $ "Append to " ++ out
        localPath <- liftIO $ makeAbsolute "bashrc"
        liftIO $ appendFile out $ "\nsource " ++ localPath ++ "\n"

    home </> ".vimrc" %> \ out -> do
        alwaysRerun
        currentVimrc <- readFile out
        putNormal $ "Append to " ++ out
        localPath <- liftIO $ makeAbsolute $ dropWhile ('.'==) $ takeFileName out
        liftIO $ appendFile out $ "\nsource " ++ localPath ++ "\n"

    home </> ".gvimrc" %> \ out -> do
        alwaysRerun
        putNormal $ "Append to " ++ out
        localPath <- liftIO $ makeAbsolute $ dropWhile ('.'==) $ takeFileName out
        liftIO $ appendFile out $ "\nsource " ++ localPath ++ "\n"

    (home </>) <$> [".gitconfig", ".ghci"] |%> \ out ->
        liftIO $ lnFile out

    home </> ".local/bin/pophoogle" %> \ out ->
        liftIO $ lnFile out

-- vim +PluginInstall +qall
-- stack install hdevtools
-- stack install hlint

    where

    checkFile :: FilePath -> FilePath -> IO ()
    checkFile ffrom fto = do
        ffromExists <- doesFileExist ffrom
        ftoExists <- doesFileExist fto
        unless ffromExists $ error $ "File does not exist " ++ ffrom
        when ftoExists $ error $ "File already exists " ++ fto
