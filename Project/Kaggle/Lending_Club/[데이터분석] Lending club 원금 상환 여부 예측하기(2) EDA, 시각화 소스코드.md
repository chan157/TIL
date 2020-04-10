# [파이썬 데이터분석] LendingClub 원금 상환 여부 예측하기(2)  EDA, 시각화 소스코드

LendingClub 데이터셋을 사용해서 원금 상환 여부를 예측하는 프로젝트를 진행하고 있습니다. 게시글 첫번째 과정에서 EDA와 데이터 시각화를 진행하였습니다. EDA와 시각화 과정에서 발생한 파이썬 코드를 이번 게시글을 통해서 공유하도록 하겠습니다.



## 사용된 라이브러리

전체 소스코드에서 시각화에 대한 부분이므로 전체 라이브러리가 나타나있습니다.

```python
import pandas as pd
import seaborn as sns
import numpy as np
import matplotlib.pyplot as plt
% matplotlib inline

# Plotly visualizations
import chart_studio.plotly as py
from plotly import tools
import plotly.figure_factory as ff
import plotly.graph_objs as go
from plotly.offline import download_plotlyjs, init_notebook_mode, plot, iplot
init_notebook_mode(connected=True)

# For oversampling Library (Dealing with Imbalanced Datasets)
from imblearn.over_sampling import SMOTE
from collections import Counter

# Other Libraries
import time

df = pd.read_csv("loan.csv", low_memory=False)

# Copy of the dataframe
df.head()
```


<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
    
    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>member_id</th>
      <th>loan_amnt</th>
      <th>funded_amnt</th>
      <th>funded_amnt_inv</th>
      <th>term</th>
      <th>int_rate</th>
      <th>installment</th>
      <th>grade</th>
      <th>sub_grade</th>
      <th>emp_title</th>
      <th>emp_length</th>
      <th>home_ownership</th>
      <th>annual_inc</th>
      <th>verification_status</th>
      <th>issue_d</th>
      <th>loan_status</th>
      <th>pymnt_plan</th>
      <th>url</th>
      <th>desc</th>
      <th>purpose</th>
      <th>title</th>
      <th>zip_code</th>
      <th>addr_state</th>
      <th>dti</th>
      <th>delinq_2yrs</th>
      <th>earliest_cr_line</th>
      <th>inq_last_6mths</th>
      <th>mths_since_last_delinq</th>
      <th>mths_since_last_record</th>
      <th>open_acc</th>
      <th>pub_rec</th>
      <th>revol_bal</th>
      <th>revol_util</th>
      <th>total_acc</th>
      <th>initial_list_status</th>
      <th>out_prncp</th>
      <th>out_prncp_inv</th>
      <th>total_pymnt</th>
      <th>total_pymnt_inv</th>
      <th>...</th>
      <th>pub_rec_bankruptcies</th>
      <th>tax_liens</th>
      <th>tot_hi_cred_lim</th>
      <th>total_bal_ex_mort</th>
      <th>total_bc_limit</th>
      <th>total_il_high_credit_limit</th>
      <th>revol_bal_joint</th>
      <th>sec_app_earliest_cr_line</th>
      <th>sec_app_inq_last_6mths</th>
      <th>sec_app_mort_acc</th>
      <th>sec_app_open_acc</th>
      <th>sec_app_revol_util</th>
      <th>sec_app_open_act_il</th>
      <th>sec_app_num_rev_accts</th>
      <th>sec_app_chargeoff_within_12_mths</th>
      <th>sec_app_collections_12_mths_ex_med</th>
      <th>sec_app_mths_since_last_major_derog</th>
      <th>hardship_flag</th>
      <th>hardship_type</th>
      <th>hardship_reason</th>
      <th>hardship_status</th>
      <th>deferral_term</th>
      <th>hardship_amount</th>
      <th>hardship_start_date</th>
      <th>hardship_end_date</th>
      <th>payment_plan_start_date</th>
      <th>hardship_length</th>
      <th>hardship_dpd</th>
      <th>hardship_loan_status</th>
      <th>orig_projected_additional_accrued_interest</th>
      <th>hardship_payoff_balance_amount</th>
      <th>hardship_last_payment_amount</th>
      <th>disbursement_method</th>
      <th>debt_settlement_flag</th>
      <th>debt_settlement_flag_date</th>
      <th>settlement_status</th>
      <th>settlement_date</th>
      <th>settlement_amount</th>
      <th>settlement_percentage</th>
      <th>settlement_term</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>2500</td>
      <td>2500</td>
      <td>2500.0</td>
      <td>36 months</td>
      <td>13.56</td>
      <td>84.92</td>
      <td>C</td>
      <td>C1</td>
      <td>Chef</td>
      <td>10+ years</td>
      <td>RENT</td>
      <td>55000.0</td>
      <td>Not Verified</td>
      <td>Dec-2018</td>
      <td>Current</td>
      <td>n</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>debt_consolidation</td>
      <td>Debt consolidation</td>
      <td>109xx</td>
      <td>NY</td>
      <td>18.24</td>
      <td>0.0</td>
      <td>Apr-2001</td>
      <td>1.0</td>
      <td>NaN</td>
      <td>45.0</td>
      <td>9.0</td>
      <td>1.0</td>
      <td>4341</td>
      <td>10.3</td>
      <td>34.0</td>
      <td>w</td>
      <td>2386.02</td>
      <td>2386.02</td>
      <td>167.02</td>
      <td>167.02</td>
      <td>...</td>
      <td>1.0</td>
      <td>0.0</td>
      <td>60124.0</td>
      <td>16901.0</td>
      <td>36500.0</td>
      <td>18124.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>N</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>Cash</td>
      <td>N</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>30000</td>
      <td>30000</td>
      <td>30000.0</td>
      <td>60 months</td>
      <td>18.94</td>
      <td>777.23</td>
      <td>D</td>
      <td>D2</td>
      <td>Postmaster</td>
      <td>10+ years</td>
      <td>MORTGAGE</td>
      <td>90000.0</td>
      <td>Source Verified</td>
      <td>Dec-2018</td>
      <td>Current</td>
      <td>n</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>debt_consolidation</td>
      <td>Debt consolidation</td>
      <td>713xx</td>
      <td>LA</td>
      <td>26.52</td>
      <td>0.0</td>
      <td>Jun-1987</td>
      <td>0.0</td>
      <td>71.0</td>
      <td>75.0</td>
      <td>13.0</td>
      <td>1.0</td>
      <td>12315</td>
      <td>24.2</td>
      <td>44.0</td>
      <td>w</td>
      <td>29387.75</td>
      <td>29387.75</td>
      <td>1507.11</td>
      <td>1507.11</td>
      <td>...</td>
      <td>1.0</td>
      <td>0.0</td>
      <td>372872.0</td>
      <td>99468.0</td>
      <td>15000.0</td>
      <td>94072.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>N</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>Cash</td>
      <td>N</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>5000</td>
      <td>5000</td>
      <td>5000.0</td>
      <td>36 months</td>
      <td>17.97</td>
      <td>180.69</td>
      <td>D</td>
      <td>D1</td>
      <td>Administrative</td>
      <td>6 years</td>
      <td>MORTGAGE</td>
      <td>59280.0</td>
      <td>Source Verified</td>
      <td>Dec-2018</td>
      <td>Current</td>
      <td>n</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>debt_consolidation</td>
      <td>Debt consolidation</td>
      <td>490xx</td>
      <td>MI</td>
      <td>10.51</td>
      <td>0.0</td>
      <td>Apr-2011</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>8.0</td>
      <td>0.0</td>
      <td>4599</td>
      <td>19.1</td>
      <td>13.0</td>
      <td>w</td>
      <td>4787.21</td>
      <td>4787.21</td>
      <td>353.89</td>
      <td>353.89</td>
      <td>...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>136927.0</td>
      <td>11749.0</td>
      <td>13800.0</td>
      <td>10000.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>N</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>Cash</td>
      <td>N</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>3</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>4000</td>
      <td>4000</td>
      <td>4000.0</td>
      <td>36 months</td>
      <td>18.94</td>
      <td>146.51</td>
      <td>D</td>
      <td>D2</td>
      <td>IT Supervisor</td>
      <td>10+ years</td>
      <td>MORTGAGE</td>
      <td>92000.0</td>
      <td>Source Verified</td>
      <td>Dec-2018</td>
      <td>Current</td>
      <td>n</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>debt_consolidation</td>
      <td>Debt consolidation</td>
      <td>985xx</td>
      <td>WA</td>
      <td>16.74</td>
      <td>0.0</td>
      <td>Feb-2006</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>10.0</td>
      <td>0.0</td>
      <td>5468</td>
      <td>78.1</td>
      <td>13.0</td>
      <td>w</td>
      <td>3831.93</td>
      <td>3831.93</td>
      <td>286.71</td>
      <td>286.71</td>
      <td>...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>385183.0</td>
      <td>36151.0</td>
      <td>5000.0</td>
      <td>44984.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>N</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>Cash</td>
      <td>N</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>30000</td>
      <td>30000</td>
      <td>30000.0</td>
      <td>60 months</td>
      <td>16.14</td>
      <td>731.78</td>
      <td>C</td>
      <td>C4</td>
      <td>Mechanic</td>
      <td>10+ years</td>
      <td>MORTGAGE</td>
      <td>57250.0</td>
      <td>Not Verified</td>
      <td>Dec-2018</td>
      <td>Current</td>
      <td>n</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>debt_consolidation</td>
      <td>Debt consolidation</td>
      <td>212xx</td>
      <td>MD</td>
      <td>26.35</td>
      <td>0.0</td>
      <td>Dec-2000</td>
      <td>0.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>12.0</td>
      <td>0.0</td>
      <td>829</td>
      <td>3.6</td>
      <td>26.0</td>
      <td>w</td>
      <td>29339.02</td>
      <td>29339.02</td>
      <td>1423.21</td>
      <td>1423.21</td>
      <td>...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>157548.0</td>
      <td>29674.0</td>
      <td>9300.0</td>
      <td>32332.0</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>N</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>Cash</td>
      <td>N</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 145 columns</p>
</div>




```python
# 데이터 상태 확인
df.info()
df.shape
```

    (2260668, 145)




```python
df.describe()
```


<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
    
    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>member_id</th>
      <th>loan_amnt</th>
      <th>funded_amnt</th>
      <th>funded_amnt_inv</th>
      <th>int_rate</th>
      <th>installment</th>
      <th>annual_inc</th>
      <th>url</th>
      <th>dti</th>
      <th>delinq_2yrs</th>
      <th>inq_last_6mths</th>
      <th>mths_since_last_delinq</th>
      <th>mths_since_last_record</th>
      <th>open_acc</th>
      <th>pub_rec</th>
      <th>revol_bal</th>
      <th>revol_util</th>
      <th>total_acc</th>
      <th>out_prncp</th>
      <th>out_prncp_inv</th>
      <th>total_pymnt</th>
      <th>total_pymnt_inv</th>
      <th>total_rec_prncp</th>
      <th>total_rec_int</th>
      <th>total_rec_late_fee</th>
      <th>recoveries</th>
      <th>collection_recovery_fee</th>
      <th>last_pymnt_amnt</th>
      <th>collections_12_mths_ex_med</th>
      <th>mths_since_last_major_derog</th>
      <th>policy_code</th>
      <th>annual_inc_joint</th>
      <th>dti_joint</th>
      <th>acc_now_delinq</th>
      <th>tot_coll_amt</th>
      <th>tot_cur_bal</th>
      <th>open_acc_6m</th>
      <th>open_act_il</th>
      <th>open_il_12m</th>
      <th>...</th>
      <th>num_actv_rev_tl</th>
      <th>num_bc_sats</th>
      <th>num_bc_tl</th>
      <th>num_il_tl</th>
      <th>num_op_rev_tl</th>
      <th>num_rev_accts</th>
      <th>num_rev_tl_bal_gt_0</th>
      <th>num_sats</th>
      <th>num_tl_120dpd_2m</th>
      <th>num_tl_30dpd</th>
      <th>num_tl_90g_dpd_24m</th>
      <th>num_tl_op_past_12m</th>
      <th>pct_tl_nvr_dlq</th>
      <th>percent_bc_gt_75</th>
      <th>pub_rec_bankruptcies</th>
      <th>tax_liens</th>
      <th>tot_hi_cred_lim</th>
      <th>total_bal_ex_mort</th>
      <th>total_bc_limit</th>
      <th>total_il_high_credit_limit</th>
      <th>revol_bal_joint</th>
      <th>sec_app_inq_last_6mths</th>
      <th>sec_app_mort_acc</th>
      <th>sec_app_open_acc</th>
      <th>sec_app_revol_util</th>
      <th>sec_app_open_act_il</th>
      <th>sec_app_num_rev_accts</th>
      <th>sec_app_chargeoff_within_12_mths</th>
      <th>sec_app_collections_12_mths_ex_med</th>
      <th>sec_app_mths_since_last_major_derog</th>
      <th>deferral_term</th>
      <th>hardship_amount</th>
      <th>hardship_length</th>
      <th>hardship_dpd</th>
      <th>orig_projected_additional_accrued_interest</th>
      <th>hardship_payoff_balance_amount</th>
      <th>hardship_last_payment_amount</th>
      <th>settlement_amount</th>
      <th>settlement_percentage</th>
      <th>settlement_term</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>0.0</td>
      <td>0.0</td>
      <td>2.260668e+06</td>
      <td>2.260668e+06</td>
      <td>2.260668e+06</td>
      <td>2.260668e+06</td>
      <td>2.260668e+06</td>
      <td>2.260664e+06</td>
      <td>0.0</td>
      <td>2.258957e+06</td>
      <td>2.260639e+06</td>
      <td>2.260638e+06</td>
      <td>1.102166e+06</td>
      <td>359156.000000</td>
      <td>2.260639e+06</td>
      <td>2.260639e+06</td>
      <td>2.260668e+06</td>
      <td>2.258866e+06</td>
      <td>2.260639e+06</td>
      <td>2.260668e+06</td>
      <td>2.260668e+06</td>
      <td>2.260668e+06</td>
      <td>2.260668e+06</td>
      <td>2.260668e+06</td>
      <td>2.260668e+06</td>
      <td>2.260668e+06</td>
      <td>2.260668e+06</td>
      <td>2.260668e+06</td>
      <td>2.260668e+06</td>
      <td>2.260523e+06</td>
      <td>580775.000000</td>
      <td>2260668.0</td>
      <td>1.207100e+05</td>
      <td>120706.000000</td>
      <td>2.260639e+06</td>
      <td>2.190392e+06</td>
      <td>2.190392e+06</td>
      <td>1.394538e+06</td>
      <td>1.394539e+06</td>
      <td>1.394539e+06</td>
      <td>...</td>
      <td>2.190392e+06</td>
      <td>2.202078e+06</td>
      <td>2.190392e+06</td>
      <td>2.190392e+06</td>
      <td>2.190392e+06</td>
      <td>2.190391e+06</td>
      <td>2.190392e+06</td>
      <td>2.202078e+06</td>
      <td>2.107011e+06</td>
      <td>2.190392e+06</td>
      <td>2.190392e+06</td>
      <td>2.190392e+06</td>
      <td>2.190237e+06</td>
      <td>2.185289e+06</td>
      <td>2.259303e+06</td>
      <td>2.260563e+06</td>
      <td>2.190392e+06</td>
      <td>2.210638e+06</td>
      <td>2.210638e+06</td>
      <td>2.190392e+06</td>
      <td>1.080200e+05</td>
      <td>108021.000000</td>
      <td>108021.000000</td>
      <td>108021.000000</td>
      <td>106184.000000</td>
      <td>108021.000000</td>
      <td>108021.000000</td>
      <td>108021.000000</td>
      <td>108021.000000</td>
      <td>35942.000000</td>
      <td>10613.0</td>
      <td>10613.000000</td>
      <td>10613.0</td>
      <td>10613.000000</td>
      <td>8426.000000</td>
      <td>10613.000000</td>
      <td>10613.000000</td>
      <td>33056.000000</td>
      <td>33056.000000</td>
      <td>33056.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>1.504693e+04</td>
      <td>1.504166e+04</td>
      <td>1.502344e+04</td>
      <td>1.309291e+01</td>
      <td>4.458076e+02</td>
      <td>7.799243e+04</td>
      <td>NaN</td>
      <td>1.882420e+01</td>
      <td>3.068792e-01</td>
      <td>5.768354e-01</td>
      <td>3.454092e+01</td>
      <td>72.312842</td>
      <td>1.161240e+01</td>
      <td>1.975278e-01</td>
      <td>1.665846e+04</td>
      <td>5.033770e+01</td>
      <td>2.416255e+01</td>
      <td>4.446293e+03</td>
      <td>4.445295e+03</td>
      <td>1.182403e+04</td>
      <td>1.180594e+04</td>
      <td>9.300142e+03</td>
      <td>2.386352e+03</td>
      <td>1.462469e+00</td>
      <td>1.360740e+02</td>
      <td>2.259328e+01</td>
      <td>3.364015e+03</td>
      <td>1.814580e-02</td>
      <td>44.164220</td>
      <td>1.0</td>
      <td>1.236246e+05</td>
      <td>19.251817</td>
      <td>4.147942e-03</td>
      <td>2.327317e+02</td>
      <td>1.424922e+05</td>
      <td>9.344199e-01</td>
      <td>2.779407e+00</td>
      <td>6.764314e-01</td>
      <td>...</td>
      <td>5.629468e+00</td>
      <td>4.774183e+00</td>
      <td>7.726402e+00</td>
      <td>8.413439e+00</td>
      <td>8.246523e+00</td>
      <td>1.400463e+01</td>
      <td>5.577951e+00</td>
      <td>1.162813e+01</td>
      <td>6.373958e-04</td>
      <td>2.813652e-03</td>
      <td>8.293767e-02</td>
      <td>2.076755e+00</td>
      <td>9.411458e+01</td>
      <td>4.243513e+01</td>
      <td>1.281935e-01</td>
      <td>4.677109e-02</td>
      <td>1.782428e+05</td>
      <td>5.102294e+04</td>
      <td>2.319377e+04</td>
      <td>4.373201e+04</td>
      <td>3.361728e+04</td>
      <td>0.633256</td>
      <td>1.538997</td>
      <td>11.469455</td>
      <td>58.169101</td>
      <td>3.010554</td>
      <td>12.533072</td>
      <td>0.046352</td>
      <td>0.077568</td>
      <td>36.937928</td>
      <td>3.0</td>
      <td>155.006696</td>
      <td>3.0</td>
      <td>13.686422</td>
      <td>454.840802</td>
      <td>11628.036442</td>
      <td>193.606331</td>
      <td>5030.606922</td>
      <td>47.775600</td>
      <td>13.148596</td>
    </tr>
    <tr>
      <th>std</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>9.190245e+03</td>
      <td>9.188413e+03</td>
      <td>9.192332e+03</td>
      <td>4.832114e+00</td>
      <td>2.671737e+02</td>
      <td>1.126962e+05</td>
      <td>NaN</td>
      <td>1.418333e+01</td>
      <td>8.672303e-01</td>
      <td>8.859632e-01</td>
      <td>2.190047e+01</td>
      <td>26.464094</td>
      <td>5.640861e+00</td>
      <td>5.705150e-01</td>
      <td>2.294831e+04</td>
      <td>2.471307e+01</td>
      <td>1.198753e+01</td>
      <td>7.547612e+03</td>
      <td>7.546657e+03</td>
      <td>9.889599e+03</td>
      <td>9.884835e+03</td>
      <td>8.304886e+03</td>
      <td>2.663086e+03</td>
      <td>1.150210e+01</td>
      <td>7.258317e+02</td>
      <td>1.271114e+02</td>
      <td>5.971757e+03</td>
      <td>1.508131e-01</td>
      <td>21.533121</td>
      <td>0.0</td>
      <td>7.416135e+04</td>
      <td>7.822086</td>
      <td>6.961656e-02</td>
      <td>8.518462e+03</td>
      <td>1.606926e+05</td>
      <td>1.140700e+00</td>
      <td>3.000784e+00</td>
      <td>9.256354e-01</td>
      <td>...</td>
      <td>3.382874e+00</td>
      <td>3.037921e+00</td>
      <td>4.701430e+00</td>
      <td>7.359114e+00</td>
      <td>4.683928e+00</td>
      <td>8.038868e+00</td>
      <td>3.293434e+00</td>
      <td>5.644027e+00</td>
      <td>2.710643e-02</td>
      <td>5.616522e-02</td>
      <td>4.935732e-01</td>
      <td>1.830711e+00</td>
      <td>9.036140e+00</td>
      <td>3.621616e+01</td>
      <td>3.646130e-01</td>
      <td>3.775338e-01</td>
      <td>1.815748e+05</td>
      <td>4.991124e+04</td>
      <td>2.300656e+04</td>
      <td>4.507298e+04</td>
      <td>2.815387e+04</td>
      <td>0.993401</td>
      <td>1.760569</td>
      <td>6.627271</td>
      <td>25.548212</td>
      <td>3.275893</td>
      <td>8.150964</td>
      <td>0.411496</td>
      <td>0.407996</td>
      <td>23.924584</td>
      <td>0.0</td>
      <td>129.113137</td>
      <td>0.0</td>
      <td>9.728138</td>
      <td>375.830737</td>
      <td>7615.161123</td>
      <td>198.694368</td>
      <td>3692.027842</td>
      <td>7.336379</td>
      <td>8.192319</td>
    </tr>
    <tr>
      <th>min</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>5.000000e+02</td>
      <td>5.000000e+02</td>
      <td>0.000000e+00</td>
      <td>5.310000e+00</td>
      <td>4.930000e+00</td>
      <td>0.000000e+00</td>
      <td>NaN</td>
      <td>-1.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>1.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>-9.500000e-09</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000</td>
      <td>1.0</td>
      <td>5.693510e+03</td>
      <td>0.000000</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>...</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>3.0</td>
      <td>0.640000</td>
      <td>3.0</td>
      <td>0.000000</td>
      <td>1.920000</td>
      <td>55.730000</td>
      <td>0.010000</td>
      <td>44.210000</td>
      <td>0.200000</td>
      <td>0.000000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>8.000000e+03</td>
      <td>8.000000e+03</td>
      <td>8.000000e+03</td>
      <td>9.490000e+00</td>
      <td>2.516500e+02</td>
      <td>4.600000e+04</td>
      <td>NaN</td>
      <td>1.189000e+01</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>1.600000e+01</td>
      <td>55.000000</td>
      <td>8.000000e+00</td>
      <td>0.000000e+00</td>
      <td>5.950000e+03</td>
      <td>3.150000e+01</td>
      <td>1.500000e+01</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>4.272580e+03</td>
      <td>4.257730e+03</td>
      <td>2.846180e+03</td>
      <td>6.936100e+02</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>3.086400e+02</td>
      <td>0.000000e+00</td>
      <td>27.000000</td>
      <td>1.0</td>
      <td>8.340000e+04</td>
      <td>13.530000</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>2.909200e+04</td>
      <td>0.000000e+00</td>
      <td>1.000000e+00</td>
      <td>0.000000e+00</td>
      <td>...</td>
      <td>3.000000e+00</td>
      <td>3.000000e+00</td>
      <td>4.000000e+00</td>
      <td>3.000000e+00</td>
      <td>5.000000e+00</td>
      <td>8.000000e+00</td>
      <td>3.000000e+00</td>
      <td>8.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>1.000000e+00</td>
      <td>9.130000e+01</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>5.073100e+04</td>
      <td>2.089200e+04</td>
      <td>8.300000e+03</td>
      <td>1.500000e+04</td>
      <td>1.510675e+04</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>7.000000</td>
      <td>39.800000</td>
      <td>1.000000</td>
      <td>7.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>16.000000</td>
      <td>3.0</td>
      <td>59.370000</td>
      <td>3.0</td>
      <td>5.000000</td>
      <td>174.967500</td>
      <td>5628.730000</td>
      <td>43.780000</td>
      <td>2227.000000</td>
      <td>45.000000</td>
      <td>6.000000</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>1.290000e+04</td>
      <td>1.287500e+04</td>
      <td>1.280000e+04</td>
      <td>1.262000e+01</td>
      <td>3.779900e+02</td>
      <td>6.500000e+04</td>
      <td>NaN</td>
      <td>1.784000e+01</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>3.100000e+01</td>
      <td>74.000000</td>
      <td>1.100000e+01</td>
      <td>0.000000e+00</td>
      <td>1.132400e+04</td>
      <td>5.030000e+01</td>
      <td>2.200000e+01</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>9.060870e+03</td>
      <td>9.043080e+03</td>
      <td>6.823385e+03</td>
      <td>1.485280e+03</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>5.884700e+02</td>
      <td>0.000000e+00</td>
      <td>44.000000</td>
      <td>1.0</td>
      <td>1.100000e+05</td>
      <td>18.840000</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>7.924000e+04</td>
      <td>1.000000e+00</td>
      <td>2.000000e+00</td>
      <td>0.000000e+00</td>
      <td>...</td>
      <td>5.000000e+00</td>
      <td>4.000000e+00</td>
      <td>7.000000e+00</td>
      <td>6.000000e+00</td>
      <td>7.000000e+00</td>
      <td>1.200000e+01</td>
      <td>5.000000e+00</td>
      <td>1.100000e+01</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>2.000000e+00</td>
      <td>1.000000e+02</td>
      <td>3.750000e+01</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>1.142985e+05</td>
      <td>3.786400e+04</td>
      <td>1.630000e+04</td>
      <td>3.269600e+04</td>
      <td>2.651650e+04</td>
      <td>0.000000</td>
      <td>1.000000</td>
      <td>10.000000</td>
      <td>60.200000</td>
      <td>2.000000</td>
      <td>11.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>36.000000</td>
      <td>3.0</td>
      <td>119.040000</td>
      <td>3.0</td>
      <td>15.000000</td>
      <td>352.605000</td>
      <td>10044.220000</td>
      <td>132.890000</td>
      <td>4172.855000</td>
      <td>45.000000</td>
      <td>14.000000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>2.000000e+04</td>
      <td>2.000000e+04</td>
      <td>2.000000e+04</td>
      <td>1.599000e+01</td>
      <td>5.933200e+02</td>
      <td>9.300000e+04</td>
      <td>NaN</td>
      <td>2.449000e+01</td>
      <td>0.000000e+00</td>
      <td>1.000000e+00</td>
      <td>5.000000e+01</td>
      <td>92.000000</td>
      <td>1.400000e+01</td>
      <td>0.000000e+00</td>
      <td>2.024600e+04</td>
      <td>6.940000e+01</td>
      <td>3.100000e+01</td>
      <td>6.712632e+03</td>
      <td>6.710320e+03</td>
      <td>1.670797e+04</td>
      <td>1.668257e+04</td>
      <td>1.339750e+04</td>
      <td>3.052220e+03</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>3.534965e+03</td>
      <td>0.000000e+00</td>
      <td>62.000000</td>
      <td>1.0</td>
      <td>1.479950e+05</td>
      <td>24.620000</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>2.132040e+05</td>
      <td>1.000000e+00</td>
      <td>3.000000e+00</td>
      <td>1.000000e+00</td>
      <td>...</td>
      <td>7.000000e+00</td>
      <td>6.000000e+00</td>
      <td>1.000000e+01</td>
      <td>1.100000e+01</td>
      <td>1.000000e+01</td>
      <td>1.800000e+01</td>
      <td>7.000000e+00</td>
      <td>1.400000e+01</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>3.000000e+00</td>
      <td>1.000000e+02</td>
      <td>7.140000e+01</td>
      <td>0.000000e+00</td>
      <td>0.000000e+00</td>
      <td>2.577550e+05</td>
      <td>6.435000e+04</td>
      <td>3.030000e+04</td>
      <td>5.880425e+04</td>
      <td>4.376900e+04</td>
      <td>1.000000</td>
      <td>2.000000</td>
      <td>15.000000</td>
      <td>78.600000</td>
      <td>4.000000</td>
      <td>17.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>56.000000</td>
      <td>3.0</td>
      <td>213.260000</td>
      <td>3.0</td>
      <td>22.000000</td>
      <td>622.792500</td>
      <td>16114.940000</td>
      <td>284.180000</td>
      <td>6870.782500</td>
      <td>50.000000</td>
      <td>18.000000</td>
    </tr>
    <tr>
      <th>max</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>4.000000e+04</td>
      <td>4.000000e+04</td>
      <td>4.000000e+04</td>
      <td>3.099000e+01</td>
      <td>1.719830e+03</td>
      <td>1.100000e+08</td>
      <td>NaN</td>
      <td>9.990000e+02</td>
      <td>5.800000e+01</td>
      <td>3.300000e+01</td>
      <td>2.260000e+02</td>
      <td>129.000000</td>
      <td>1.010000e+02</td>
      <td>8.600000e+01</td>
      <td>2.904836e+06</td>
      <td>8.923000e+02</td>
      <td>1.760000e+02</td>
      <td>4.000000e+04</td>
      <td>4.000000e+04</td>
      <td>6.329688e+04</td>
      <td>6.329688e+04</td>
      <td>4.000000e+04</td>
      <td>2.819250e+04</td>
      <td>1.427250e+03</td>
      <td>3.985955e+04</td>
      <td>7.174719e+03</td>
      <td>4.219205e+04</td>
      <td>2.000000e+01</td>
      <td>226.000000</td>
      <td>1.0</td>
      <td>7.874821e+06</td>
      <td>69.490000</td>
      <td>1.400000e+01</td>
      <td>9.152545e+06</td>
      <td>9.971659e+06</td>
      <td>1.800000e+01</td>
      <td>5.700000e+01</td>
      <td>2.500000e+01</td>
      <td>...</td>
      <td>7.200000e+01</td>
      <td>7.100000e+01</td>
      <td>8.600000e+01</td>
      <td>1.590000e+02</td>
      <td>9.100000e+01</td>
      <td>1.510000e+02</td>
      <td>6.500000e+01</td>
      <td>1.010000e+02</td>
      <td>7.000000e+00</td>
      <td>4.000000e+00</td>
      <td>5.800000e+01</td>
      <td>3.200000e+01</td>
      <td>1.000000e+02</td>
      <td>1.000000e+02</td>
      <td>1.200000e+01</td>
      <td>8.500000e+01</td>
      <td>9.999999e+06</td>
      <td>3.408095e+06</td>
      <td>1.569000e+06</td>
      <td>2.118996e+06</td>
      <td>1.110019e+06</td>
      <td>6.000000</td>
      <td>27.000000</td>
      <td>82.000000</td>
      <td>434.300000</td>
      <td>43.000000</td>
      <td>106.000000</td>
      <td>21.000000</td>
      <td>23.000000</td>
      <td>185.000000</td>
      <td>3.0</td>
      <td>943.940000</td>
      <td>3.0</td>
      <td>37.000000</td>
      <td>2680.890000</td>
      <td>40306.410000</td>
      <td>1407.860000</td>
      <td>33601.000000</td>
      <td>521.350000</td>
      <td>181.000000</td>
    </tr>
  </tbody>
</table>
<p>8 rows × 109 columns</p>
</div>



# 결측치 확인


```python
nulls = df.isnull().sum(axis=0)
nulls.sort_values().plot(kind='bar',)
```


    <matplotlib.axes._subplots.AxesSubplot at 0x7faa9f5af828>




![png](output_5_1.png)



```python
# 데이터 결측치 시각화 2
sns.barplot(data=nulls, x=nulls.index, y=nulls.values)
plt.title('The number of nulls', fontsize=20)
plt.figsize = (19,16)
```


![png](output_6_0.png)



# Loan Status

```python
# Loan Status 범주 값들의 수 확인
df['loan_status'].value_counts().plot(kind='bar')
plt.title('Loan State value counts')
plt.show()
```


![png](output_7_0.png)



```python
# 파이플롯으로 비율 시각화
fig = plt.figure()
df['loan_status'].value_counts().plot.pie(autopct='%1.2f%%',labels=None)
plt.title('Loan State value counts')
plt.show()

df['loan_status'].value_counts()
```


![png](output_8_0.png)

    Fully Paid                                             1041952
    Current                                                 919695
    Charged Off                                             261655
    Late (31-120 days)                                       21897
    In Grace Period                                           8952
    Late (16-30 days)                                         3737
    Does not meet the credit policy. Status:Fully Paid        1988
    Does not meet the credit policy. Status:Charged Off        761
    Default                                                     31
    Name: loan_status, dtype: int64





# Loan Condition


```python
# 현재 진행중인 대출과 정책위반 대출 제거
loan_status = ['Fully Paid', 'Late (31-120 days)', 'In Grace Period',
       'Charged Off', 'Late (16-30 days)', 'Default']

def needed(status):
  if status in loan_status:
    return True
  else:
    return False
df['status'] = df['loan_status'].apply(needed)
df.drop(df[df['status']==False].index, inplace=True, errors='ignore')
```


```python
# 40%의 데이터가 제거되어 행 개수가 많이 줄어든 것을 확인할 수 있음
len(df)
```


    1338224




```python
# 대출 상태 분류
def loan_conditions(status):
  if status == 'Fully Paid':
    return 'Good'
  else:
    return 'Bad'
df['loan_condition'] = df['loan_status'].apply(loan_conditions)
```


```python
# 간단하게 Good Loan과 Bad Loan을 파이 플롯으로 확인
df['loan_condition'].value_counts().plot.pie(autopct="%1.2f%%")
```


    <matplotlib.axes._subplots.AxesSubplot at 0x7faa9d2ae668>




![png](output_14_1.png)



# 연도별 분류


```python
# 연도 구분 열 추가
dt_series = pd.to_datetime(df['issue_d'])
df['year'] = dt_series.dt.year
```


```python
# 대출 상태에 따른 시각화
f = plt.figure(figsize=(16,12))
ax1 = f.add_subplot(221)
ax2 = f.add_subplot(222)
ax3 = f.add_subplot(212)

colors = ["#3791D7", "#D72626"]
labels =["Good Loans", "Bad Loans"]

# 전체 plot에 대한 타이틀
plt.suptitle('Information on Loan Conditions', fontsize=20)

# Pie 플롯을 사용해 비율 확인
df["loan_condition"].value_counts().plot.pie(
    explode=[0,0.25], autopct='%1.2f%%', ax=ax1, 
    shadow=True, colors=colors,labels=labels, 
    fontsize=12, startangle=0)
# explode : 살짝 때어지는 것
# autopct : 파이 그래프 내의 비율 수치 

# ax1의 타이틀과 라벨
ax1.set_title('State of Loan', fontsize=16)
ax1.set_xlabel('% of Condition of Loans', fontsize=14)

# countpot을 사용해 상태별 개수 비교
sns.countplot('loan_condition', data=df, ax=ax2, palette=colors)
ax2.set_title('Condition of Loans', fontsize=20)
ax2.set_xticklabels(labels=labels, rotation='horizontal')
ax2.set(ylabel=('count'))

# 연도별로 대출 개수 비교
sns.barplot(x="year", y="loan_amnt", hue="loan_condition", data=df, palette=colors, 
            estimator=lambda y: len(y) / len(df) * 100)
# estimator 그래프에 적용할 함수 
# y 값으로 표현할 값에 대한 함수 적용 가능
# mean, median 또는 자신이 원하는 것 등
ax3.set(ylabel="(%)")
ax3.set_title('Proportion of Loan Condition by Year', fontsize=20)

plt.show()
```


![png](output_17_0.png)



# 대출 금액 비교


```python
fig = plt.figure(figsize=(12,7))
ax1 = fig.add_subplot(121)
ax2 = fig.add_subplot(122)
#대출 세부 상태에 따른 금액
df.groupby(['year','loan_status'])['loan_amnt'].sum().unstack().plot(kind='bar', figsize=(12,6), ax = ax1)
#대출 세부 상태에 따른 금액 로그스케일
df.groupby(['year','loan_status'])['loan_amnt'].sum().unstack().plot(kind='bar', figsize=(12,6), logy=True, ax = ax2)
```


    <matplotlib.axes._subplots.AxesSubplot at 0x7faa9cb52ef0>




![png](output_19_1.png)



```python
# 대출 세부 상태에 따른 금액
# sns를 사용해서
fig = plt.figure(figsize=(10,6))
ax1 = fig.subplots()

sns.barplot(x='year',y='loan_amnt',hue='loan_status',data=df,
            estimator = lambda y : len(y) / len(df) * 100,
            ax = ax1)
ax1.set_title('The Proprotion of Loan by Year and Status', fontsize=20)
plt.ylabel('(%)', fontsize=20)
plt.xlabel('year', fontsize=20)
ax1.tick_params(axis='x', labelsize=14)
ax1.tick_params(axis='y', labelsize=14)
```


![png](output_20_0.png)



```python
fig = plt.figure(figsize=(10,6))
ax1 = fig.subplots()

# estimator의 default는 mean
sns.barplot(x='year',y='loan_amnt', data=df,  ax = ax1)
ax1.set_title('Average Amount of Loan by Year', fontsize=20)
plt.ylabel('($)', fontsize=20)
plt.xlabel('year', fontsize=20)
ax1.tick_params(axis='x', labelsize=14)
ax1.tick_params(axis='y', labelsize=14)
```


![png](output_21_0.png)



```python
fig = plt.figure(figsize=(10,6))
ax1 = fig.subplots()

# lambda로 estimator 정의 가능
# len()으로 건수로 확인할 수 있음
# 연도벌 대출 건수를 시각화해서 확인
sns.barplot(x='year',y='loan_amnt', data=df,  ax = ax1, estimator=lambda x : len(x))
ax1.set_title('Average Amount of Loan by Year', fontsize=20)
plt.ylabel('count', fontsize=20)
plt.xlabel('year', fontsize=20)
ax1.tick_params(axis='x', labelsize=14)
ax1.tick_params(axis='y', labelsize=14)
```

![png](output_22_0.png)



# 지역 단위 구분


```python
df['addr_state'].unique()

# Make a list with each of the regions by state.

west = ['CA', 'OR', 'UT','WA', 'CO', 'NV', 'AK', 'MT', 'HI', 'WY', 'ID']
south_west = ['AZ', 'TX', 'NM', 'OK']
south_east = ['GA', 'NC', 'VA', 'FL', 'KY', 'SC', 'LA', 'AL', 'WV', 'DC', 'AR', 'DE', 'MS', 'TN' ]
mid_west = ['IL', 'MO', 'MN', 'OH', 'WI', 'KS', 'MI', 'SD', 'IA', 'NE', 'IN', 'ND']
north_east = ['CT', 'NY', 'PA', 'NJ', 'RI','MA', 'MD', 'VT', 'NH', 'ME']



df['region'] = np.nan

def finding_regions(state):
    if state in west:
        return 'West'
    elif state in south_west:
        return 'SouthWest'
    elif state in south_east:
        return 'SouthEast'
    elif state in mid_west:
        return 'MidWest'
    elif state in north_east:
        return 'NorthEast'
    


df['region'] = df['addr_state'].apply(finding_regions)
```


```python
f, ax = plt.subplots()
cmap = plt.cm.inferno

by_interest_rate = df.groupby(['year', 'region']).annual_inc.mean()
by_interest_rate.unstack().plot(kind='bar', colormap=cmap, grid=False, 
                                legend=False, ax=ax, figsize=(10,6))
ax1.set_title('Average Interest Rate by Region', fontsize=14)
```


    Text(0.5, 1, 'Average Interest Rate by Region')




![png](output_26_1.png)



# 신용 등급


```python
# Let's visualize how many loans were issued by creditscore
f, ((ax1, ax2)) = plt.subplots(1, 2)
cmap = plt.cm.coolwarm

by_credit_score = df.groupby(['year', 'grade']).loan_amnt.mean()
by_credit_score.unstack().plot(legend=False, ax=ax1, figsize=(14, 4), colormap=cmap)
ax1.set_title('Loans issued by Credit Score', fontsize=14)
    
    
by_inc = df.groupby(['year', 'grade']).int_rate.mean()
by_inc.unstack().plot(ax=ax2, figsize=(14, 4), colormap=cmap)
ax2.set_title('Interest Rates by Credit Score', fontsize=14)

ax2.legend(bbox_to_anchor=(-1.0, -0.3, 1.7, 0.1), loc=5, prop={'size':12},
           ncol=7, mode="expand", borderaxespad=0.)
```


    <matplotlib.legend.Legend at 0x7faa9b337ac8>




![png](output_28_1.png)



```python
# 세부 신용 등급에 따른 대출 상태 비교
test = df.groupby(['sub_grade','loan_condition']).loan_amnt.size()
test.unstack().plot(colormap=cmap, kind='bar')
```


    <matplotlib.axes._subplots.AxesSubplot at 0x7faa9b2fb668>




![png](output_29_1.png)



```python
# 세부 신용 등급별 대출 상태의 비율

## 신용 등급 총합과 비율 데이터 프레임 생성
test2 = test.unstack()
test2.loc['Total',:] = test2.sum(axis=0)
test2['Total'] = test2.sum(axis=1)
test2['Good Ratio'] = test2['Good'] * 100 / test2['Total']
test2['Bad Ratio'] = test2['Bad'] * 100 / test2['Total']

## plot
test2.ix[:-1,['Good Ratio','Bad Ratio']].plot(kind='bar', colormap=cmap, figsize=(15,6))
plt.xlabel('Grade', fontsize=15)
plt.ylabel('(%)', fontsize=15)
plt.title('Loan Condition by Credit Score', fontsize=20)
plt.xticks(rotation=0)
plt.show()
test2
```


![png](output_30_0.png)

<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }
    
    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>loan_condition</th>
      <th>Bad</th>
      <th>Good</th>
      <th>Total</th>
      <th>Good Ratio</th>
      <th>Bad Ratio</th>
    </tr>
    <tr>
      <th>sub_grade</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>A1</th>
      <td>1608.0</td>
      <td>39898.0</td>
      <td>41506.0</td>
      <td>96.125861</td>
      <td>3.874139</td>
    </tr>
    <tr>
      <th>A2</th>
      <td>1986.0</td>
      <td>34121.0</td>
      <td>36107.0</td>
      <td>94.499682</td>
      <td>5.500318</td>
    </tr>
    <tr>
      <th>A3</th>
      <td>2443.0</td>
      <td>34574.0</td>
      <td>37017.0</td>
      <td>93.400330</td>
      <td>6.599670</td>
    </tr>
    <tr>
      <th>A4</th>
      <td>4043.0</td>
      <td>47043.0</td>
      <td>51086.0</td>
      <td>92.085894</td>
      <td>7.914106</td>
    </tr>
    <tr>
      <th>A5</th>
      <td>5937.0</td>
      <td>56841.0</td>
      <td>62778.0</td>
      <td>90.542865</td>
      <td>9.457135</td>
    </tr>
    <tr>
      <th>B1</th>
      <td>8373.0</td>
      <td>61658.0</td>
      <td>70031.0</td>
      <td>88.043866</td>
      <td>11.956134</td>
    </tr>
    <tr>
      <th>B2</th>
      <td>9389.0</td>
      <td>63533.0</td>
      <td>72922.0</td>
      <td>87.124599</td>
      <td>12.875401</td>
    </tr>
    <tr>
      <th>B3</th>
      <td>11717.0</td>
      <td>69071.0</td>
      <td>80788.0</td>
      <td>85.496608</td>
      <td>14.503392</td>
    </tr>
    <tr>
      <th>B4</th>
      <td>13729.0</td>
      <td>68606.0</td>
      <td>82335.0</td>
      <td>83.325439</td>
      <td>16.674561</td>
    </tr>
    <tr>
      <th>B5</th>
      <td>15465.0</td>
      <td>66207.0</td>
      <td>81672.0</td>
      <td>81.064502</td>
      <td>18.935498</td>
    </tr>
    <tr>
      <th>C1</th>
      <td>18015.0</td>
      <td>67050.0</td>
      <td>85065.0</td>
      <td>78.822077</td>
      <td>21.177923</td>
    </tr>
    <tr>
      <th>C2</th>
      <td>18215.0</td>
      <td>60870.0</td>
      <td>79085.0</td>
      <td>76.967819</td>
      <td>23.032181</td>
    </tr>
    <tr>
      <th>C3</th>
      <td>18796.0</td>
      <td>56283.0</td>
      <td>75079.0</td>
      <td>74.965037</td>
      <td>25.034963</td>
    </tr>
    <tr>
      <th>C4</th>
      <td>20701.0</td>
      <td>54100.0</td>
      <td>74801.0</td>
      <td>72.325236</td>
      <td>27.674764</td>
    </tr>
    <tr>
      <th>C5</th>
      <td>19705.0</td>
      <td>48363.0</td>
      <td>68068.0</td>
      <td>71.051008</td>
      <td>28.948992</td>
    </tr>
    <tr>
      <th>D1</th>
      <td>15682.0</td>
      <td>35999.0</td>
      <td>51681.0</td>
      <td>69.656160</td>
      <td>30.343840</td>
    </tr>
    <tr>
      <th>D2</th>
      <td>14575.0</td>
      <td>30585.0</td>
      <td>45160.0</td>
      <td>67.725864</td>
      <td>32.274136</td>
    </tr>
    <tr>
      <th>D3</th>
      <td>13292.0</td>
      <td>26517.0</td>
      <td>39809.0</td>
      <td>66.610565</td>
      <td>33.389435</td>
    </tr>
    <tr>
      <th>D4</th>
      <td>12625.0</td>
      <td>23339.0</td>
      <td>35964.0</td>
      <td>64.895451</td>
      <td>35.104549</td>
    </tr>
    <tr>
      <th>D5</th>
      <td>11054.0</td>
      <td>19399.0</td>
      <td>30453.0</td>
      <td>63.701442</td>
      <td>36.298558</td>
    </tr>
    <tr>
      <th>E1</th>
      <td>9107.0</td>
      <td>14802.0</td>
      <td>23909.0</td>
      <td>61.909741</td>
      <td>38.090259</td>
    </tr>
    <tr>
      <th>E2</th>
      <td>8539.0</td>
      <td>13059.0</td>
      <td>21598.0</td>
      <td>60.463932</td>
      <td>39.536068</td>
    </tr>
    <tr>
      <th>E3</th>
      <td>7682.0</td>
      <td>10972.0</td>
      <td>18654.0</td>
      <td>58.818484</td>
      <td>41.181516</td>
    </tr>
    <tr>
      <th>E4</th>
      <td>6759.0</td>
      <td>9189.0</td>
      <td>15948.0</td>
      <td>57.618510</td>
      <td>42.381490</td>
    </tr>
    <tr>
      <th>E5</th>
      <td>6636.0</td>
      <td>8184.0</td>
      <td>14820.0</td>
      <td>55.222672</td>
      <td>44.777328</td>
    </tr>
    <tr>
      <th>F1</th>
      <td>4469.0</td>
      <td>5633.0</td>
      <td>10102.0</td>
      <td>55.761235</td>
      <td>44.238765</td>
    </tr>
    <tr>
      <th>F2</th>
      <td>3426.0</td>
      <td>3851.0</td>
      <td>7277.0</td>
      <td>52.920159</td>
      <td>47.079841</td>
    </tr>
    <tr>
      <th>F3</th>
      <td>2916.0</td>
      <td>3284.0</td>
      <td>6200.0</td>
      <td>52.967742</td>
      <td>47.032258</td>
    </tr>
    <tr>
      <th>F4</th>
      <td>2453.0</td>
      <td>2489.0</td>
      <td>4942.0</td>
      <td>50.364225</td>
      <td>49.635775</td>
    </tr>
    <tr>
      <th>F5</th>
      <td>2063.0</td>
      <td>1963.0</td>
      <td>4026.0</td>
      <td>48.758073</td>
      <td>51.241927</td>
    </tr>
    <tr>
      <th>G1</th>
      <td>1536.0</td>
      <td>1514.0</td>
      <td>3050.0</td>
      <td>49.639344</td>
      <td>50.360656</td>
    </tr>
    <tr>
      <th>G2</th>
      <td>1106.0</td>
      <td>1067.0</td>
      <td>2173.0</td>
      <td>49.102623</td>
      <td>50.897377</td>
    </tr>
    <tr>
      <th>G3</th>
      <td>871.0</td>
      <td>773.0</td>
      <td>1644.0</td>
      <td>47.019465</td>
      <td>52.980535</td>
    </tr>
    <tr>
      <th>G4</th>
      <td>707.0</td>
      <td>613.0</td>
      <td>1320.0</td>
      <td>46.439394</td>
      <td>53.560606</td>
    </tr>
    <tr>
      <th>G5</th>
      <td>652.0</td>
      <td>502.0</td>
      <td>1154.0</td>
      <td>43.500867</td>
      <td>56.499133</td>
    </tr>
    <tr>
      <th>Total</th>
      <td>296272.0</td>
      <td>1041952.0</td>
      <td>1338224.0</td>
      <td>77.860807</td>
      <td>22.139193</td>
    </tr>
  </tbody>
</table>
</div>




```python
fig = plt.figure(figsize=(16,12))

ax1 = fig.add_subplot(221)
ax2 = fig.add_subplot(222)
ax3 = fig.add_subplot(212)

cmap = plt.cm.coolwarm_r

# 등급별 대출양
loans_by_region = df.groupby(['grade', 'loan_condition']).size()
loans_by_region.unstack().plot(kind='bar', stacked=True, colormap=cmap, ax=ax1, grid=False)
ax1.set_title('Type of Loans by Grade', fontsize=14)

# 세부 등급별
loans_by_grade = df.groupby(['sub_grade', 'loan_condition']).size()
loans_by_grade.unstack().plot(kind='bar', stacked=True, colormap=cmap, ax=ax2, grid=False)
ax2.set_title('Type of Loans by Sub-Grade', fontsize=14)

# 연도별 평균 이자율
by_interest = df.groupby(['year', 'loan_condition']).int_rate.mean()
by_interest.unstack().plot(ax=ax3, colormap=cmap)
ax3.set_title('Average Interest rate by Loan Condition', fontsize=14)
ax3.set_ylabel('Interest Rate (%)', fontsize=12)
plt.show()
```


![png](output_31_0.png)



# 마무리

EDA 진행 과정에서 발생된 기본적인 데이터 시각화에 관련해서 소스코드를 모와서 작성하였습니다.

다음 글에서는 데이터 전처리를 진행하고 전처리에 해당되는 소스코드를 첨부하겠습니다.