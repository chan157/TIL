def solution(answers):
    list1 = [1,2,3,4,5]
    list2 = [2,1,2,3,2,4,2,5]
    list3 = [3,3,1,1,2,2,4,4,5,5]

    length = len(answers)
    cnt1 = cnt2 = cnt3 = 0

    for i in range(length) :
        if answers[i] == list1[(i%5)]:
            cnt1 += 1
        if answers[i] == list2[(i%8)]:
            cnt2 += 1
        if answers[i] == list3[(i%10)]:
            cnt3 += 1       

    answer = []
    score = [cnt1, cnt2, cnt3]

    
    for i, s in enumerate(score):
        if s == max(score):
            answer.append(i+1)

    return answer    
##  return [i + 1 for i, v in enumerate(score) if v == max(score)]