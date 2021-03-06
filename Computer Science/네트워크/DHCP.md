# DHCP

> 네트워크는 결국 자료를 목적지까지 잘 전달하는 논리/설비라 생각한다. 이를 위한 기술중에서 내 주소와 상대방 주소를 알아야 한다. 상대방 주소를 알기위한 DNS 등을 공부하기 전에 내 주소를 할당받는 DHCP에 대해 공부하자.

### DHCP (Dynamic Host Configuration Protocol)

간단하게 얘기해 볼 때, DHCP는 클라이언트에게 네트워크의 할당이나 IP 주소의 할당을 자동화 하는 역할을 합니다.

클라이언트가 DHCP 서버에 요청을 보내면 해당 서버는 클라이언트에게 서버가 가지고 있는 IP Pool에서 사용 가능한 IP를 할당하여 줍니다.

DHCP는 보통 라우터에 같이 탑재되지만, 별도로 서버에도 설치가 가능하다고 합니다.

DHCP는 크게 3가지의 기능을 합니다. **IP의 임대, IP의 갱신, IP의 반환** 입니다.



### IP 임대

특정 클라이언트에게 짧은 기간 IP를 빌려준다. 임대 기간은 길게는 8일에서 짧게는 2~3시간 설정된다. 내가 있는 컴퓨터는 2시간 임대하고, 30분 간격으로 임대 시간을 다시 리뉴얼 해줬다. 이는 도시에서 IP가 빠르게 회전시켜 IP Pool을 유지 하기 위함이다.



### DHCP 할당 순서

#### DHCP Discover

IP를 가지지 않는 클라이언트는 MAC 주소를 기반으로 IP를 할당 받는다. IP를 할당받기 위해서는 로컬 네트워크의 Discover packet을 broadcast한다. Discover packet이 broadcast되는 경우, 해당 호스트가 속한 네트워크의 모든 호스트에게 패킷이 전달되지만, DHCP 서버를 제외한 모든 호스트는 패킷을 파기하고 DHCP에 Discover packet이 정상적으로 도착한 경우, 다음 단계로 넘어간다.

#### DHCP Offer

현재 DHCP 서버는 클라이언트로 부터 Discover packet을 수신한 상태이며 , 그 후 offer packet을 broadcast 한다. MAC 주소에는 Discover 패킷을 발행한 호스트의 MAC 주소를 담아 송신하게 된다.

#### DHCP Request

3단계에서는 클라이언트가 DHCP서버의 offer packet를 받게 되고 같은 네트워크안에 DHCP 서버가 존재한다고 해당 패킷을 수신함으로서 판단한다. 클라이언트는 DHCP로 부터 IP를 할당 받기 위해 request 패킷을 송신하며, DHCP는 클라이언트가 보낸 request 패킷을 수신할 경우 4단계로 넘어간다.

#### DHCP ACK

DHCP가 클라이언트가 보낸 request 패킷을 수신한경우, IP 풀에서 할당 할 수 있는 IP가 뭐가 있나 뒤적뒤적(?)이기 시작한다. 보통 IP 주소는 192.168.0.2 ~ 0.254 까지 임대풀에 넣어 둔다. 이 경우 일반적으로 IP의 할당은 가장 앞쪽에 비어있는 IP부터 할당하게 된다. 할당할 IP를 찾은 경우 IP주소를 패킷에 담아 응답하게 되고 클라이언트가 정상적으로 해당 패킷을 수신한 경우 IP가 할당된다.



### 고정 IP

DHCP는 해당 서버에서 임대가능한 IP 풀 범위 내에서 IP를 할당해주기 때문에 사용중인 IP인지 아닌지에 대한 정보를 정확히 알지 못합니다. 만약 고정 IP로 사용중인 IP를 클라이언트에게 할당해주게 된다면 IP가 충돌하는 현상이 일어나죠.

이런 경우 IP 주소 풀을 옮기거나 DHCP의 예약기능을 통해 해당 IP에 대해 임대기간을 -1로 설정하면 무한대에 가까운 임대기간 동안 IP를 이용할 수 있습니다.



### IP 갱신

IP 갱신은 총 2번 일어난다. 임대 시간 50% 지점과 87.5%가 지난 시점이다. 임대 갱신이 두번 일어나는 이유는 임대 갱신동안 네트워크 불안정으로 임대 갱신이 이루어지지 않았을 경우를 대비하기 위함이다.
