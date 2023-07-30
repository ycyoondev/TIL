# 230730 LeetCode

## Two Sum (Easy)

> https://leetcode.com/problems/two-sum/

### 문제 설명

Given an array of integers `nums` and an integer `target`, return *indices of the two numbers such that they add up to `target`*.

You may assume that each input would have ***exactly\* one solution**, and you may not use the *same* element twice.

You can return the answer in any order.

 

**Example 1:**

```
Input: nums = [2,7,11,15], target = 9
Output: [0,1]
Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
```

**Example 2:**

```
Input: nums = [3,2,4], target = 6
Output: [1,2]
```

**Example 3:**

```
Input: nums = [3,3], target = 6
Output: [0,1]
```

 

**Constraints:**

- `2 <= nums.length <= 104`
- `-109 <= nums[i] <= 109`
- `-109 <= target <= 109`
- **Only one valid answer exists.**



### 알고리즘 포인트

정렬, 그리디

### 나의 답안

```python
class Solution(object):
    def twoSum(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: List[int]
        """
        nums = list(enumerate(nums))
        nums.sort(key=lambda x:x[1])
        for i in range(len(nums)-1):
            for j in range(i+1, len(nums)):
                if (nums[i][1] + nums[j][1] == target):
                    return [nums[i][0], nums[j][0]]
                elif (nums[i][1] + nums[j][1] > target):
                    break
```

### 생각

가장 쉽게 전체를 확인하는 방법은 O(N^2)이다. 나는 전체를 확인하지 않기 위해 정렬한 뒤 target 값이 초과되는 시점에서 뒤를 보지 않는 방식으로 구현했다. 이는 최악의 경우에는 O(NlogN)이 나온다.

다른 사람 풀이를 보니 Set를 써서 O(N)으로 구현한 코드가 있었다. 나를 제외한 값들이 Set에 들어있다면, 탐색에 O(1)으로 할수 있으니, 정렬하지 말고 전체를 확인하면서 하나씩 set에 넣고, 지금 내 수와 합쳐서 target이 되는 수가 set에 있는지 확인하는 방식이다.

```python
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        numToIndex = {}
        for i in range(len(nums)):
            if target - nums[i] in numToIndex:
                return [numToIndex[target - nums[i]], i]
            numToIndex[nums[i]] = i
        return []
```

