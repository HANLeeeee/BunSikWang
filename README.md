# 비비빅의 분식왕
> 2022.07.19 ~ 2022.07.25 (1주간) <br/>

<img width="1702" alt="image" src="https://user-images.githubusercontent.com/74815957/184084569-b942faed-978a-4671-b459-8b54831d1b4c.png">
<img width="1723" alt="image" src="https://user-images.githubusercontent.com/74815957/184084645-310d0c98-8fb0-418a-90b8-096489400ee3.png">
<img width="1723" alt="image" src="https://user-images.githubusercontent.com/74815957/184084683-d90a840c-92c1-4613-983c-a3655cc2eea1.png">


## 📌 Description 
- 주어진 시간안에 손님에게 메뉴를 전달하는 게임
- 손님이 오면 주문을 받고 원하는 메뉴를 가지고 손님테이블로 전달하면 된다.

<br/><br/>
## 📌 How To 
- 처음에 단무지를 가져다주면서 주문을 받는다.
- 테이블의 타이머 시간안에 주문을 받아야한다. 테이블 타이머의 시간이 3번 끝나면 손님은 나간다.
- 주문을 받으면 손님이 주문한 메뉴를 가져다 준다. 이때도 테이블 타이머의 시간이 3번 끝나면 손님이 나간다.
- 메뉴를 잘못만들면 쓰레기통에 버려야한다. 버리게 되면 점수에서 마이너스가 된다.
- 손님이 간 자리에 쓰레기를 치운다.
- 게임속 시간이 18시가 되면 영업이 끝난다.


<br/><br/>
## 📌 Project Goal
- Multi-Thread 사용 <br/>
- BGM 구현 <br/>
- 아이디 입력 후 랭킹 구현 <br/>


<br/><br/>
## 📌 Main Logic
- 게임을 시작하면 Thread 시작 <br/>
- 게임타이머가 끝나면 Thread 종료 <br/>
- 손님이 오면 해당 테이블에 Thread 시작 <br/>


<br/><br/>
## 📌 알게된 점
- DispatchQueue.global().async 사용 
DispatchQueue.main.sync


<br/><br/>
## 📌 아쉬운 점
- 상단탭바 구현<br/>
- 장바구니로 바로 가기


<br/><br/>

