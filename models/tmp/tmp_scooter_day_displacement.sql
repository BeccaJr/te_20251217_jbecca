{{ config(
    tags=['temp', 'q2']
) }}

SELECT
    decoded_id
    , provider
    , msa
    , date
    , ST_DISTANCE(
        ST_MAKEPOINT(start_lng, start_lat)
        , ST_MAKEPOINT(end_lng, end_lat)
    ) AS displacement
FROM
    {{ ref('tmp_scooter_day_first_last') }}