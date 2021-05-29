import random


def sortear(nums, maximo):
    x = 0
    while x < len(nums):
        while True:
            numero = random.randint(1, maximo)
            if numero in nums:
                continue
            nums[x] = numero
            x += 1
            break
    return sorted(nums)


print(sortear([0, 0, 0, 0, 0], 50), "\t", sortear([0, 0], 10))
print("Boa sorte!")
