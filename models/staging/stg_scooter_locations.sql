{{ config(
    tags=['staging']
) }}

WITH source AS (
    SELECT *
    FROM {{ source('scooters', 'SCOOTER_LOCATIONS') }}
)

SELECT
    DATA:attributes::STRING AS attributes
    , DATA:battery::INT AS battery
    , DATA:decoded_id::STRING AS decoded_id
    , DATA:provider:slug::STRING AS provider
    , DATA:lat::FLOAT AS latitude
    , DATA:lng::FLOAT AS longitude
    , DATA:hexagons:"7"::STRING AS hex_7
    , DATA:extracted_at::TIMESTAMP AS extracted_at
    , DATA:type::STRING AS scooter_type
FROM source