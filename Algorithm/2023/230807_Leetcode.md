# 230730 LeetCode

## Palindrome Number (Easy)

> https://leetcode.com/problems/palindrome-number/

### 문제 설명

Given an integer `x`, return `true` *if* `x` *is a* **palindrome**, and `false` *otherwise*.

**Example 1:**

```
Input: x = 121
Output: true
Explanation: 121 reads as 121 from left to right and from right to left.
```

**Example 2:**

```
Input: x = -121
Output: false
Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.
```

**Example 3:**

```
Input: x = 10
Output: false
Explanation: Reads 01 from right to left. Therefore it is not a palindrome.
```

 

**Constraints:**

- `-231 <= x <= 231 - 1`

 

### 알고리즘 포인트

투포인터

### 나의 답안

```python
class Solution(object):
    def isPalindrome(self, x):
        """
        :type x: int
        :rtype: bool
        5개면 12321 0,1
        4개면 1221 0,1
        6개면 123321 0,1,2
        """
        if x < 0 or (x!=0 and x%10==0):
            return False
        # 다 찾지말고 투포인터로 아니면 끊기
        x = str(x)
        for i in range(len(x)//2):
            if x[i] != x[-1 * (i+1)]:
                return False
        return True

```

### 생각

처음에 상위 70%정도에서 코드 한줄을 수정하니 상위 99.2%로 올라갔다. 0이 아닌 x가 1의 자리가 0인 경우 무조건 False를 반환한다는 논리를 추가했기때문이다. 되게 작은 부분이었는데 큰 효고를 보았다. 투포인터라는 알고리즘 자체는 여렵지 않았고, O(N/2)를 이용한 방법이 가장 최소로 이 문제를 푸는 방법일것 같다. 
