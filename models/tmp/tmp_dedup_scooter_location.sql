{{ config(
    tags=['temp']
) }}

WITH ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY decoded_id, extracted_at
            ORDER BY extracted_at DESC
        ) AS rank
    FROM {{ ref('stg_scooter_location') }}
)
SELECT
    *
FROM 
    ranked
WHERE 
    rank = 1