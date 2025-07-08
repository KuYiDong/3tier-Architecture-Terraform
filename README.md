### VPC  
**[리소스 맵]**  
<br>
<img src="images/vpc_리소스맵.png" alt="리소스맵" width="800"/>  
<br><br>

**[서브넷]**  
<br>
<img src="images/Subnet.png" alt="서브넷" width="800"/>  
<br>

- **총 8개 서브넷**
  - 퍼블릭 서브넷 2개
  - 프라이빗 서브넷 6개
    - WAS & WEB 서브넷 4개
    - Database 서브넷 2개

<br><br>

### EC2  
<img src="images/EC2.png" alt="EC2" width="600"/>  
<br><br>

---

### ALB  
<img src="images/ALB.png" alt="ALB" width="600"/>  
<br>

- **Web_alb**: 웹서버를 대상으로 로드 밸런싱
- **Was_alb**: 어플리케이션 서버를 대상으로 로드 밸런싱

<br><br>

**[Web_ALB_Target_group]**  
<img src="images/ALB_TG1.png" alt="Web-tg" width="600"/>  
<br><br>

**[Was_ALB_Target_group]**  
<img src="images/ALB_TG.png" alt="Was-tg" width="600"/>  
<br><br>

---

### ASG  
<img src="images/ASG_image2.png" alt="Web ASG" width="600"/>  
<br><br>
<img src="images/ASG_image.png" alt="Was ASG" width="600"/>  
<br><br>

---

### RDS  
<img src="images/RDS.png" alt="RDS" width="600"/>  
<br>

- **Multi-AZ 구성**으로 장애 시 자동 Failover
- 백업 보존 기간: 최대 7일

