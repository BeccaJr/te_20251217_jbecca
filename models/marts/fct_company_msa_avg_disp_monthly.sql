{{ config(
    tags=['fact', 'marts', 'q2']
) }}

SELECT
    {{ dbt_utils.generate_surrogate_key([
        "msa",
        "provider",
        "DATE_TRUNC('month', date)"
    ]) }} AS company_msa_month_sk
    , msa
    , provider
    , DATE_TRUNC('month', date) AS month
    , AVG(displacement) AS average_displacement
FROM
    {{ ref('tmp_scooter_day_displacement') }}
GROUP BY
    1, 2, 3, 4