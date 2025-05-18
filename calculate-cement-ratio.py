target_weight = 750
container_weight = 50
after_curing_ratio = 0.827

before_curing_weight = (target_weight - container_weight) / after_curing_ratio

print(before_curing_weight)
water_amount = before_curing_weight / 5
cement_amount = (before_curing_weight / 5) * 4
print(f"amount of water {water_amount}")
print(f"amount of concrete {cement_amount}")

