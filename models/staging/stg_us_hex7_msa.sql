{{ config(
    tags=['staging']
) }}

SELECT
    HEX7 AS hex_7
    , HEX7_CENTROID AS hex_7_centroid
    , MSA AS msa
FROM {{ source('scooters', 'US_HEX7_MSA') }}