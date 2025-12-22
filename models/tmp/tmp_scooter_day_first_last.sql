{{ config(
    tags=['temp', 'q2']
) }}

WITH
    ranked AS (
        SELECT
            d.decoded_id
            , d.provider
            , m.msa
            , DATE(d.extracted_at) AS date
            , d.latitude as lat
            , d.longitude as lng
            , ROW_NUMBER() OVER (PARTITION BY d.decoded_id, DATE(d.extracted_at) ORDER BY d.extracted_at ASC) AS rank_first
            , ROW_NUMBER() OVER (PARTITION BY d.decoded_id, DATE(d.extracted_at) ORDER BY d.extracted_at DESC) AS rank_last
        FROM
            {{ ref('tmp_dedup_scooter_locations') }} d
        JOIN
            {{ ref('stg_us_hex7_msa') }} m
        ON
            d.hex_7 = m.hex_7
    )
    SELECT
        decoded_id
        , provider
        , msa
        , date
        , MAX(CASE WHEN rank_first = 1 THEN lat END) AS start_lat
        , MAX(CASE WHEN rank_first = 1 THEN lng END) AS start_lng
        , MAX(CASE WHEN rank_last = 1 THEN lat END) AS end_lat
        , MAX(CASE WHEN rank_last = 1 THEN lng END) AS end_lng
    FROM
        ranked
    GROUP BY
        decoded_id
        , provider
        , msa
        , date