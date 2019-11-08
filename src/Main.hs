module Main where

import Control.Concurrent.Async (Async, async, wait)

main = do
    echo "Optionals"
    echo "---------"
    print (addTwoOptionals (Just 2) (Just 3))
    print (addTwoOptionals (Just 2) Nothing)
    print (addTwoOptionals Nothing (Just 3))
    print (addTwoOptionals Nothing Nothing)

    -- Optionals
    -- ---------
    -- Just 5
    -- Nothing
    -- Nothing
    -- Nothing

    echo ""
    echo "Promises"
    echo "--------"
    promiseA <- async (pure 1)
    promiseB <- async (pure 2)
    result <- addTwoPromises (wait promiseA) (wait promiseB)
    print result

    -- Promises
    -- --------
    -- 3

    echo ""
    echo "Abstracted: Optionals"
    echo "---------------------"
    print (addTwoWrappedThings (Just 2) (Just 3))
    print (addTwoWrappedThings (Just 2) Nothing)
    print (addTwoWrappedThings Nothing (Just 3))
    print (addTwoWrappedThings Nothing Nothing)

    echo ""
    echo "Abstracted: Promises"
    echo "--------------------"
    promiseA <- async (pure 1)
    promiseB <- async (pure 2)
    result <- addTwoWrappedThings (wait promiseA) (wait promiseB)
    print result

  where
    echo = putStrLn

-- JS: a === null ? null : (b === null ? null : a + b)
addTwoOptionals :: Maybe Int -> Maybe Int -> Maybe Int
addTwoOptionals maybeA maybeB = do
  a <- maybeA
  b <- maybeB
  return (a + b)

-- JS: promiseA.then(a => promiseB.then(b => console.log(a + b)));
addTwoPromises :: IO Int -> IO Int -> IO Int
addTwoPromises promiseA promiseB = do
  a <- promiseA
  b <- promiseB
  return (a + b)

-- JS: Nearly impossible to write this!
addTwoWrappedThings :: Monad m => m Int -> m Int -> m Int
addTwoWrappedThings somethingA somethingB = do
  a <- somethingA
  b <- somethingB
  return (a + b)
