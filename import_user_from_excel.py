import pandas as pd
import requests

dataFrame = pd.read_excel("DS_formatted.xlsx", sheet_name="Sheet1")

row = dataFrame.loc[3]
print(row[1])

headers = {
    'accept': 'text/plain',
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI1IiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiT3duZXIiLCJleHAiOjE3MTEyMTMwNzEsImlzcyI6IkpXVEF1dGhlbnRpY2F0aW9uU2VydmVyIiwiYXVkIjoiSldUU2VydmljZVBvc3RtYW5DbGllbnQifQ.I_f79oUObM5FuFwvmz8b1m_g3RK0k3pW0AJjYt3GSaY',
    'Content-Type': 'application/json',
}


for row in range(3, len(dataFrame.index)):

    name = dataFrame.loc[row][1]
    nickName = dataFrame.loc[row][2]
    bankNumber = dataFrame.loc[row][3]
    bankName = dataFrame.loc[row][4]
    identityNumber = dataFrame.loc[row][6]
    image = 'https://firebasestorage.googleapis.com/v0/b/test-1d90e.appspot.com/o/public%2F4af87d12-ce65-4980-9d08-7fbad898cb3c.png?alt=media&token=f5dd231d-1b9f-4ea5-8556-f8fbd040d617'
    address = dataFrame.loc[row][9]
    phoneNumber = dataFrame.loc[row][10]

    if phoneNumber == 'nan':
        continue

    print(name)

    json_data = {
        'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/test-1d90e.appspot.com/o/public%2F4af87d12-ce65-4980-9d08-7fbad898cb3c.png?alt=media&token=f5dd231d-1b9f-4ea5-8556-f8fbd040d617',
        'name': str(name),
        'nickName': str(nickName),
        'identity': str(identityNumber),
        'identityCreateAt': '2023-08-12T18:59:35.694Z',
        'identityAddress': 'chưa có',
        'phonenumber': str(phoneNumber),
        'bankname': str(bankName),
        'banknumber': str(bankNumber),
        'address': str(address),
        'additionalInfo': '',
    }

    try:
        response = requests.post(
            'https://huimanagementbackend.gentlesmoke-0f05f43d.southeastasia.azurecontainerapps.io/subusers',
            #'http://localhost:57679/subusers',
            headers=headers,
            json=json_data,
        )

        print(response.content)

        

        if (response.status_code == 400):

            if ('SUB_USER_ALREADY_EXIST' in response.content):
                continue

            print('error')
            break
    except:
        print('skip')
    

    


