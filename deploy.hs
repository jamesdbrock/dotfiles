#! /usr/bin/env stack
-- stack --verbosity warn --system-ghc runghc --package shake --package strict
-- vim: set filetype=haskell :

import Development.Shake hiding (doesFileExist)
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util
import System.Directory
import Control.Monad
import System.Posix.Files
import System.Environment
import System.IO
import qualified System.IO.Strict as IO.Strict
import System.IO.Error
import Data.List

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

    home </> ".bashrc" %> \ out -> do
        alwaysRerun
        contents <- liftIO $ liftM (either (const "") id) $ eitherReadFile out
        let comment = "# bashrc included from jamesdbrock/dotfiles"
        unless (isInfixOf comment contents) $ do
            putNormal $ "Prepend to " ++ out
            localPath <- liftIO $ makeAbsolute "bashrc"
            _ <- liftIO $ eitherWriteFile out $ unlines [comment, "source " ++ localPath, "", contents]
            return ()

    home </> ".vimrc" %> \ out -> do
        alwaysRerun
        contents <- liftIO $ liftM (either (const "") id) $ eitherReadFile out
        let comment = "# vimrc included from jamesdbrock/dotfiles"
        unless (isInfixOf comment contents) $ do
            putNormal $ "Prepend to " ++ out
            localPath <- liftIO $ makeAbsolute "vimrc"
            _ <- liftIO $ eitherWriteFile out $ unlines [comment, "source " ++ localPath, "", contents]
            return ()

    home </> ".gvimrc" %> \ out -> do
        alwaysRerun
        contents <- liftIO $ liftM (either (const "") id) $ eitherReadFile out
        let comment = "# gvimrc included from jamesdbrock/dotfiles"
        unless (isInfixOf comment contents) $ do
            putNormal $ "Prepend to " ++ out
            localPath <- liftIO $ makeAbsolute "gvimrc"
            _ <- liftIO $ eitherWriteFile out $ unlines [comment, "source " ++ localPath, "", contents]
            return ()

    (home </>) <$> [".gitconfig", ".ghci"] |%> \ out ->
        liftIO $ lnFile out

    home </> ".local/bin/pophoogle" %> \ out ->
        liftIO $ lnFile out

    home </> "vimrc.copy" %> \ out -> do
        need ["vimrc"]
        liftIO $ copyFile "vimrc" out

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

    eitherReadFile :: FilePath -> IO (Either IOError String)
    eitherReadFile path = tryIOError $ withFile path ReadMode IO.Strict.hGetContents

    eitherWriteFile :: FilePath -> String -> IO (Either IOError ())
    eitherWriteFile path contents = tryIOError $ withFile path WriteMode (`hPutStr` contents)

