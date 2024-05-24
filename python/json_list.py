
import json

uma_string= '[{"service_id":"A001","locomotiveId":["159-008","159-002"]},{"service_id":"A002","locomotiveId":["159-002"]},{"service_id":"A003","locomotiveId":["159-008"]}]'
a_list_now = json.loads(uma_string)
#print(type(a_list_now))
#print(len(a_list_now))
for i in range(len(a_list_now)):
    print(a_list_now[i])
print("FIM")