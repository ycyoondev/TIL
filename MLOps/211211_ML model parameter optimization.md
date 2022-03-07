# Hyper Parameter 최적화

> 지난번에 모델의 학습을 관리하는 W & B에 대해 전반적으로 공부했다. 이를 사용해서 어떻게 하이퍼 파라미터를 최적화 할 수 있는지 공부해본다. 

### Hyper Parameter Optimization

ML 모델을 개발할때 필수적으로 해야하며, 모델을 개선할때 가장 적은 노력으로 모델 성능을 높일 수 있는 방법이다. 따라서 HPO는 머신러닝 개발자가 자주 해야하며, 개발자의 입장에서 이것을 자동화를 통해 효과적으로 관리해야 한다. 이를 통해서 어떤 파라미터가 성능에 중요한지, 각 파라미터는 어떤 범위를 가져야하며 어떤 값이 효율이 좋은지 등을 알 수 있다. 또한 이러한 정보는 연구원들이 모델을 개선할때 중요한 참고자료가 된다.



### W & B Sweeps 

이전에 공부한 W&B에 제공되는 기능이다. 공식 연습용 예제로 실습을 통해서 공부한다.

#### notebook

[참고 파일]

https://github.com/wandb/examples/blob/master/examples/wandb-sweeps/sweeps-python/notebook.ipynb 

[작성 파일]

https://github.com/ycyoondev/ML-study/blob/master/211211_wandb-sweeps.ipynb



#### python 실행파일

https://docs.wandb.ai/guides/sweeps/configuration 방법 참고



### W & B Sweeps 추가 기능

W&B에서 직접 여러가지 모델과 파라미터를 사용하여 각 경우마다 정확도를 구해주기때문에 유용하다. 캐글과 같은 대회를 위한 데이터 세트별 최고 파라미터 찾기에 효과적일것이다. 또한 리포트 생성 기능과, 어떤 파라미터가 가장 영향력이 높은지 확인이 가능하다.



### Ref.

- https://docs.wandb.ai/guides/sweeps
- https://towardsdatascience.com/how-to-use-w-b-sweeps-with-lightgbm-for-hyperparameter-tuning-b67c3cac435c
- https://pebpung.github.io/wandb/2021/10/10/WandB-2.html
- https://pebpung.github.io/wandb/2021/10/06/WandB-1.html
