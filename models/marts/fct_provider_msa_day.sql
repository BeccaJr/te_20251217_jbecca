{{ config(
    tags=['fact', 'marts', 'q1']
) }}

WITH
scooters_locations AS (
    SELECT
        provider
        , decoded_id
        , hex_7
        , DATE(extracted_at) AS date
    FROM
        {{ ref('tmp_dedup_scooter_locations') }}
)
, msa_mapping AS (
    SELECT
        hex_7
        , msa
    FROM
        {{ ref('stg_us_hex7_msa') }}
)
, scooter_msa AS (
    SELECT
        sl.provider
        , sl.decoded_id
        , sl.date
        , mm.msa
    FROM
        scooters_locations sl
    INNER JOIN
        msa_mapping mm
    ON
        sl.hex_7 = mm.hex_7
)
, grouping AS (
    SELECT
        provider
        , msa
        , date
        , COUNT(DISTINCT decoded_id) AS count_scooters
    FROM
        scooter_msa
    GROUP BY
        provider
        , msa
        , date
)
, final AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key([
            "msa",
            "provider",
            "date"
        ]) }} AS provider_msa_day_sk
        , msa
        , provider
        , date
        , count_scooters
    FROM
        grouping
)
SELECT
    *
FROM
    final