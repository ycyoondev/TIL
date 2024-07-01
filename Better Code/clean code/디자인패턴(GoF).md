# 디자인패턴

### Factory Method Pattern

- 객체를 생성하는 역할을 한 곳에서 한다. (Java기준 삭제는 신경쓰지않음)
- Clinet는 생성 방법을 알지 못한다. 다만 어떤 인스턴스를 사용할지를 결정한다.

```java
// Product 인터페이스
interface Vehicle {
    void drive();
}

// ConcreteProduct 클래스 1
class Car implements Vehicle {
    @Override
    public void drive() {
        System.out.println("자동차를 운전합니다.");
    }
}

// ConcreteProduct 클래스 2
class Bike implements Vehicle {
    @Override
    public void drive() {
        System.out.println("자전거를 탑니다.");
    }
}

// Creator 인터페이스
interface VehicleFactory {
    Vehicle createVehicle();
}

// ConcreteCreator 클래스 1
class CarFactory implements VehicleFactory {
    @Override
    public Vehicle createVehicle() {
        return new Car();
    }
}

// ConcreteCreator 클래스 2
class BikeFactory implements VehicleFactory {
    @Override
    public Vehicle createVehicle() {
        return new Bike();
    }
}

public class FactoryMethodExample {
    public static void main(String[] args) {
        VehicleFactory carFactory = new CarFactory();
        Vehicle car = carFactory.createVehicle();
        car.drive();

        VehicleFactory bikeFactory = new BikeFactory();
        Vehicle bike = bikeFactory.createVehicle();
        bike.drive();
    }
}
```



### Builder Pattern

- 객체 생성 단계에서 인자가 많을 경우 인자에 대한 가독성이 떨어지는 문제를 보안하기 위한 방법이다. 
- setter를 사용할 수 있지만, 이렇게 하는 이유는 객체를 불변하게 보장하기 위해서다.

```java
public class NutritionFacts {
    private final int servingSize; // 필수
    private final int servings; // 필수
    private final int calories; // 선택
    private final int fat; // 선택
    private final int sodium; // 선택
    private final int carbohydrate; // 선택

    public static class Builder {
        // 필수 파라미터는 기본값 -1로 초기화하여 설정되었는지 확인
        private int servingSize = -1;
        private int servings = -1;

        // 선택적 파라미터는 기본값으로 초기화
        private int calories = 0;
        private int fat = 0;
        private int sodium = 0;
        private int carbohydrate = 0;

        public Builder() {}

        public Builder servingSize(int val) {
            servingSize = val;
            return this;
        }

        public Builder servings(int val) {
            servings = val;
            return this;
        }

        public Builder calories(int val) {
            calories = val;
            return this;
        }

        public Builder fat(int val) {
            fat = val;
            return this;
        }

        public Builder sodium(int val) {
            sodium = val;
            return this;
        }

        public Builder carbohydrate(int val) {
            carbohydrate = val;
            return this;
        }

        public NutritionFacts build() {
            if (servingSize < 0 || servings < 0) {
                throw new IllegalStateException("servingSize and servings must be set.");
            }
            return new NutritionFacts(this);
        }
    }

    private NutritionFacts(Builder builder) {
        servingSize = builder.servingSize;
        servings = builder.servings;
        calories = builder.calories;
        fat = builder.fat;
        sodium = builder.sodium;
        carbohydrate = builder.carbohydrate;
    }
}

// 사용 예시
public class Main {
    public static void main(String[] args) {
        NutritionFacts cocaCola = new NutritionFacts.Builder()
                .servingSize(240)
                .servings(8)
                .calories(100)
                .sodium(35)
                .carbohydrate(27)
                .build();
    }
}
```

빌더 패턴에서 필수값을 도메인 로직으로 넣을 수 있다. 여기서 validation이 어떤 객체에서 수행해야하는지 역할을 생각하고 작성해야한다.

### Singleton Pattern

- Singleton은 로직상 오로지 한개의 인스턴스만 있어야할 경우 사용하는 생성 패턴이다.
- 공유 리소스 사용이 필요하거나, 메모리 사용을 제한해야 할 경우에 사용한다.

```java
public class Singleton {
    // Singleton 인스턴스를 저장할 private static 변수
    private static Singleton instance;

    // private 생성자를 통해 외부에서 인스턴스 생성을 방지
    private Singleton() {}

    // Singleton 인스턴스를 반환하는 public static 메소드
    public static Singleton getInstance() {
        // instance가 null인 경우에만 인스턴스 생성
        if (instance == null) {
            instance = new Singleton();
        }
        return instance;
    }

    // Singleton 인스턴스의 메소드 예시
    public void someMethod() {
        // 여기에 기능 구현
    }
}

// 사용 예시
public class Main {
    public static void main(String[] args) {
        // Singleton 인스턴스 얻기
        Singleton singleton = Singleton.getInstance();

        // Singleton 인스턴스의 메소드 사용
        singleton.someMethod();
    }
}
```

만약 멀티스레드 환경이라면 getInstance()에 `synchronized`를 붙여서 사용해야한다. 여러 스레드에서 동시에 getInstance()를 최초호출 했다면 싱글톤이 무너질 수 있다. 그러나 `synchronized` 키워드는 성능 저하를 일으킬 수 있다. 메서드 전체에 `synchronized`를 사용하면 해당 메서드가 호출될 때마다 스레드 간의 경쟁(lock contention)이 발생할 수 있으며, 이는 특히 고성능이 요구되는 애플리케이션에서 문제가 될 수 있다.
