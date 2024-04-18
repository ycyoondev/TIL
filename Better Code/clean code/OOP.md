### 시스템 개발 시 중요한 모듈화

1. **재사용성(Reusability)**: 잘 설계된 모듈은 다른 프로젝트나 프로그램에서 쉽게 재사용할 수 있습니다. 이는 개발 시간과 비용을 줄이는 데 큰 도움이 됩니다.
2. **유지보수성(Maintainability)**: 프로그램이 모듈로 나뉘어져 있으면, 특정 기능이나 데이터 구조에 문제가 발생했을 때 해당 모듈만 수정하면 됩니다. 이는 전체 코드의 안정성을 높이고 유지보수를 용이하게 합니다.
3. **가독성(Readability)**: 모듈화를 통해 코드를 더 읽기 쉽고 이해하기 쉽게 만들 수 있습니다. 각 모듈은 특정 기능이나 목적에 초점을 맞추므로, 프로그램의 전체 구조를 파악하기가 더 쉬워집니다.
4. **확장성(Scalability)**: 모듈화된 프로그램은 새로운 기능이나 요구 사항을 추가하기 쉽습니다. 새 모듈을 추가하거나 기존 모듈을 확장함으로써 프로그램을 발전시킬 수 있습니다.



### 의존도 분배

의존도란 소스코드가 바라보고있는 코드가 어떤지이다. 다른 클래스를 참고하는 경우에 그 클래스에 대한 의존 관계가 생긴다.

1. 낮은 결합도와 높은 응집도

- **낮은 결합도(Low Coupling)**: 모듈 간의 의존성을 최소화하여, 한 모듈의 변경이 다른 모듈에 미치는 영향을 줄입니다. 이를 통해 각 모듈의 독립성을 높이고 재사용성을 증가시킵니다.
- **높은 응집도(High Cohesion)**: 한 모듈 내부의 요소들이 강하게 연관되어 있어야 합니다. 이는 모듈이 하나의 잘 정의된 역할만을 수행하도록 해 해당 모듈을 이해하고 재사용하기 쉽게 만듭니다.

2. 의존성 주입(Dependency Injection)

의존성 주입은 객체가 필요로 하는 의존성을 외부에서 생성하여 전달하는 기법입니다. 이 방식은 모듈 간의 결합도를 낮추고, 테스트 용이성을 높이며, 코드의 유연성을 증가시킵니다.

3. 인터페이스와 추상 클래스 사용

인터페이스와 추상 클래스를 사용하여 구체적인 구현체보다는 추상화에 의존하도록 합니다. 이는 구현 세부 사항의 변경이 인터페이스를 사용하는 코드에 영향을 미치지 않도록 도와주며, 시스템의 다양한 부분을 쉽게 교체 가능하게 만듭니다.

4. 단일 책임 원칙(Single Responsibility Principle, SRP)

각 클래스는 하나의 책임만을 가져야 합니다. 이 원칙을 따르면, 클래스가 변경되는 이유는 오직 하나여야 하며, 이는 시스템의 복잡성을 줄이고 유지 보수를 용이하게 합니다.

5. 모듈 간의 계약 정의

모듈 간의 상호작용을 명시적인 계약(예: 인터페이스, API 명세)으로 정의합니다. 이는 모듈 간의 의존성을 명확하게 하고, 각 모듈이 계약을 준수함으로써 시스템의 안정성을 높입니다.

6. 리팩토링과 지속적인 개선

시스템을 개발하는 동안 지속적으로 코드를 리팩토링하고, 의존성을 관리하는 방법을 개선합니다. 이는 기술 부채를 줄이고, 프로젝트가 성장함에 따라 유연하게 대응할 수 있도록 합니다.



### DI, Factory

```java
class Phone {
    void call() {
        System.out.println("Calling...");
    }
}

class SmartPhone extends Phone {
    void call() {
        System.out.println("Smart Calling...");
    }

    void internet() {
        System.out.println("INTERNET");
    }
}


class BrickPhone extends Phone {
    void call() {
        System.out.println("전화안돼 장난감");
    }

    void internet() {
        System.out.println("INTERNET");
    }
}

public class Cal {

    static void date(Phone myPhone) {
        myPhone.call();
    }

    //Simple Facotyr Method Pattern
    static Phone factory(String name) {
        if (name.equals("brick")) return new BrickPhone();
        if (name.equals("smart")) return new SmartPhone();
        return null;
    }

    public static void main(String[] args) {
        //다형성을 이용한 구현방법
        //1. DI (Dependency Inejction) : 참조를 넣어주는것
        date(new SmartPhone());

        //2. Factory
        Phone p = factory("smart");

        //1 + 2 합체
        date(factory("brick"));
    }
}
```



### SOLID

#### Single Responsibility Principle (SRP)

- 모든 클래스는 하나의 책임만 가지며, 클래스는 그 책임을 완전히 캡슐화해야 한다.
- 클래스가 제공하는 모든 기능은 이 책임과 부합해야 한다.

##### 리팩토링 적용 방법

- Extract Class를 통해 혼재된 각 책임을 각각의 개별 클래스로 분할하여 클래스 당 하
  나의 책임만을 맡도록 함
- 책임만 분리하는 것이 아니라 분리된 두 클래스간의 관계 복잡도를 줄이도록 설계
- Extract Class된 각각의 클래스들이 유사하고 비슷한 책임을 중복해서 갖고 있다면
  Extract Superclass를 사용
- 책임을 기존의 어떤 클래스로 모으거나, 이럴만한 클래스가 없다면 새로운 클래스를
  만들어 해결

##### KATA 연습 https://github.com/bsferreira/solid/blob/master/src/com/github/bsferreira/solid/srp/violation/Vehicle.java

```java
public class Vehicle {

    private final int maxFuel;
    private int remainingFuel;

    public Vehicle(final int maxFuel) {
        this.maxFuel = maxFuel;
        remainingFuel = maxFuel;
    }

    public int getMaxFuel() {
        return maxFuel;
    }

    public int getRemainingFuel() {
        return remainingFuel;
    }

    public void setRemainingFuel(final int remainingFuel) {
        this.remainingFuel = remainingFuel;
    }

    public void accelerate() {
        remainingFuel--;
    }
}

public class GasStation {
    public void reFuel(Vehicle vehicle){
        vehicle.setRemainingFuel(vehicle.getMaxFuel());
    }
}
```





#### Open / Closed Principle (OCP)

변경은 쉬워야하지만 종속성은 적어야한다는 의미이다.

보통 Interface를 사용하여 원리를 지킨다.



#### Liskov Substitution Principle (LSP)

리스코프 교수님이 만든 원칙이다.

어렵게 말하면 동작을 바꾸지 않고 base대신 sub 클래스를 사용할 수 있어야한다.

상위 객체가 지원하는 기능은 하위 객체가 지원해야한다는 의미이다. 상속받은 자식 객체는 상위 객체를 넣을 수 있는 코드에 넣어서 동작되도록 해야한다.



#### Interface Segregation Principle (ISP)

사용하지 않는 메서드를 의존하지 않도록 Interface로 분리하는것이다.

너무 큰 interface를 만들지 않고, 필요한 함수만 사용하도록 해야한다. 이 과정에서 interface가 서로 상속하거나, interface를 여러개 구현하여 사용할 수 있다.



#### Dependency Inversion Principle (DIP)

의존성을 Interface에 두어 Interface를 참고하도록 만든다.

병렬적으로 같은 Interface를 사용하는 코드가 생겼을경우 interface 구현채만 바꾸면 되어 유지보수가 쉬워진다.



