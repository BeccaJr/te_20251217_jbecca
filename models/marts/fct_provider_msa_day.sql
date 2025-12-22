{{ config(
    tags=['fact', 'marts']
) }}

SELECT
    {{ dbt_utils.generate_surrogate_key([
        "m.msa",
        "s.provider",
        "DATE(s.extracted_at)"
    ]) }} AS provider_msa_day_sk
    , m.msa
    , s.provider
    , DATE(s.extracted_at) AS date
    , COUNT(DISTINCT s.decoded_id) AS count_scooters
FROM
    {{ ref('temp_dedup_scooter_location') }} s
INNER JOIN
    {{ ref('stg_us_hex7_msa') }} m
ON
    s.hex_7 = m.hex_7
GROUP BY
    1, 2, 3, 4