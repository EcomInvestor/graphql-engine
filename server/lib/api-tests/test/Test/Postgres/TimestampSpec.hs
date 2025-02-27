{-# LANGUAGE QuasiQuotes #-}

-- | Test that Postgres databases correctly roundtrip timestamps.
--
-- https://hasura.io/docs/latest/mutations/postgres/insert/#insert-multiple-objects-of-the-same-type-in-the-same-mutation
module Test.Postgres.TimestampSpec (spec) where

import Data.Aeson (Value)
import Data.List.NonEmpty qualified as NE
import Harness.Backend.Citus qualified as Citus
import Harness.Backend.Postgres qualified as Postgres
import Harness.GraphqlEngine (postGraphql)
import Harness.Quoter.Graphql (graphql)
import Harness.Quoter.Yaml (yaml)
import Harness.Test.Fixture qualified as Fixture
import Harness.Test.Schema (Table (..), table)
import Harness.Test.Schema qualified as Schema
import Harness.TestEnvironment (TestEnvironment)
import Harness.Yaml (shouldReturnYaml)
import Hasura.Prelude
import Test.Hspec (SpecWith, describe, it)

--------------------------------------------------------------------------------
-- Preamble

spec :: SpecWith TestEnvironment
spec =
  Fixture.run
    ( NE.fromList
        [ (Fixture.fixture $ Fixture.Backend Fixture.Postgres)
            { Fixture.setupTeardown = \(testEnv, _) ->
                [ Postgres.setupTablesAction schema testEnv
                ]
            },
          (Fixture.fixture $ Fixture.Backend Fixture.Citus)
            { Fixture.setupTeardown = \(testEnv, _) ->
                [ Citus.setupTablesAction schema testEnv
                ]
            }
        ]
    )
    tests

--------------------------------------------------------------------------------
-- Schema

schema :: [Schema.Table]
schema =
  [ (table "test")
      { tableColumns =
          [ Schema.column "time" Schema.TUTCTime
          ]
      }
  ]

--------------------------------------------------------------------------------
-- Tests

tests :: Fixture.Options -> SpecWith TestEnvironment
tests opts = do
  let shouldBe :: IO Value -> Value -> IO ()
      shouldBe = shouldReturnYaml opts

  describe "Timestamps" do
    it "Roundtrips timestamps" \testEnvironment -> do
      let expected :: Value
          expected =
            [yaml|
              data:
                insert_hasura_test:
                  returning:
                    - time: "0001-01-01T00:00:57"
            |]

          actual :: IO Value
          actual =
            postGraphql
              testEnvironment
              [graphql|
                mutation {
                  insert_hasura_test(objects:[{
                    time: "0001-01-01T00:00:57Z"
                  }]) {
                    returning {
                      time
                    }
                  }
                }
              |]

      actual `shouldBe` expected
