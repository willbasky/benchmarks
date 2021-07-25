

module ValidateInput
    ( validateInput
    , validateInputOptimized
    , validateInputOptimized2
    , validateInputAtto
    ) where

import qualified Data.Char as C
import qualified Data.Set as Set
import Data.Text (Text)
import qualified Data.Text as T
import Data.Attoparsec.Text
import Control.Applicative


-- Text approach
validateInput :: Text -> Bool
validateInput txt =
  ((T.unpack txt !! 0) `elem` validCahrs) && not (containSpecialChars txt)

containSpecialChars :: Text -> Bool
containSpecialChars txt = any isSpecialChar (Set.fromList $ T.unpack txt)

isSpecialChar :: Char -> Bool
isSpecialChar a = Set.notMember a $ Set.fromList (validCahrs ++ ['-','_'])

validCahrs :: String
validCahrs = (['a'..'z'] ++ ['A'..'Z'] ++ ['0','1','2','3','4','5','6','7','8','9'])


-- Text optimized approach
-- it consumes unicode chars.
validateInputOptimized :: Text -> Bool
validateInputOptimized txt =
  C.isAlphaNum (T.unpack txt !! 0) && (alphaNumSpecial txt)

alphaNumSpecial :: Text -> Bool
alphaNumSpecial txt = all (\c -> isSpecial c || C.isAlphaNum c)  (Set.fromList $ T.unpack txt)

isSpecial :: Char -> Bool
isSpecial a = a == '-' || a == '_'

-- Text optimized approach 2

validateInputOptimized2 :: Text -> Bool
validateInputOptimized2 orderId = isAlphaNumOpt2 (T.unpack orderId !! 0) && (alphaNumSpecial2 orderId)

alphaNumSpecial2 :: Text -> Bool
alphaNumSpecial2 orderId = all (\c -> isSpecial c || isAlphaNumOpt2 c) (Set.fromList $ T.unpack orderId)

isAlphaNumOpt2 :: Char -> Bool
isAlphaNumOpt2 a = (C.ord a >= 97 && C.ord a <=122) || (C.ord a >= 65 && C.ord a <= 90) || C.isDigit a

-- Attoparsec approach

runParser :: Parser a -> Text -> Either String a
runParser p t = parseOnly (p <* endOfInput) t

validateInputAtto:: Text -> Bool
validateInputAtto txt = case runParser textParser txt of
  Left _ -> False
  Right _ -> True

textParser :: Parser Text
textParser = do
  f <- alphaNum
  ts <- many' (try alphaNumAndSpecial)
  pure $ T.pack $ f:ts

alphaNumAndSpecial :: Parser Char
alphaNumAndSpecial = try alphaNum <|> try special

alphaNum :: Parser Char
alphaNum = satisfy $ inClass "a-zA-Z0-9"

special :: Parser Char
special = satisfy $ inClass "-_"