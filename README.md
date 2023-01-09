포트폴리오
---

프로젝트 명: Terraform 및 AWS를 활용한 웹 서버 구축 </br>
수행 목적 : 자주 활용되는 lac(Infrastructure As Code) 도구인 Terraform으로 AWS 서비스 구축 </br>
개발 환경 및 사용 기술: mac,terraform,aws </br>
구성 날짜: 2022.12.26 ~ 2022.12.28 </br>

기술 및 도구
---

<div align="left">
 <img src="https://img.shields.io/badge/AWS-232F3E?style=flat&logo=Amazon AWS&logoColor=white"/>
 <img src="https://img.shields.io/badge/Terraform-7B42BC?style=flat&logo=Terraform&logoColor=white"/>
 <img src="https://img.shields.io/badge/MacOS-000000?style=flat&logo=MacOS&logoColor=white"/>
</div>

구성도
---

프로젝트의 문제점 및 해결방안
---
문제점: 테라폼으로 생성 후 테스트를 해보려고 하는데 Private Subnet에서 NAT 게이트 웨이를 만들고, </br> 라우팅 까지 설정하였는데도 인터넷이 안되는 문제가 발생하였습니다. </br>
해결방안: NAT 게이트웨이는 Private Subnet과 외부와 통신 매개체 이기 때문에 외부에 접근할 수 있어야 하기 때문에 서브넷을 Public 서브넷으로 할당을 해야하는데,
Private Subnet으로 할당을 해서 생긴 문제였고, NAT 게이트웨이를 만들 때 Public Subnet으로 할당 하였더니 문제가 해결 되었습니다.

프로젝트 후기
---
AWS SAA 자격증을 공부를 하면서 실습도 몇번 하면서 공부를 하면서 해서, 해당 프로젝트를 시작할때에 몇 시간이면 끝나겠지 싶었는데,</br>
위와 같은 문제점이 발생하였고, 해당 원인을 찾는데 많은 시간을 소모하였습니다.</br>
해당 프로젝트를 통해서 “모든 옵션 및 자료를 좀 꼼꼼히 봐야겠다.” 라고 생각하게 되었고, 만든 코드에 대하여 형상관리를 할 수 있는 깃 허브라는 것도 알게된 프로젝트 였습니다.

