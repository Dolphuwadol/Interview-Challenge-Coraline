##### 1
# Import library used for connecting to web api and for cleaning Dataframe data and calculating numbers
import requests
import pandas as pd
import numpy as np

# Create functions for calling APIs through URLs//? Result=20 'is 20 calls
# Data structure stored as JSON
def get_data():

    res = requests.get("https://randomuser.me/api/?results=20")
    res = res.json()
    res = res['results']

    return res

# Create a function to receive user data in JSON format and store data in Dataframe format
def format_data(users):
    formatted_data = []
# For loop to find and store data from the API into a Dataframe
    for user in users:
        data = {} # Create a dictionary for storing data
        data['first_name'] = user['name']['first']
        data['last_name'] = user['name']['last']
        data['gender'] = user['gender']
		location = user['location']
# Create column address inside 'location' by fetching dictionary: street containing number, name /city, state, country
        data['address'] = f"{str(location['street']['number'])} {location['street']['name']}, " \
                          f"{location['city']}, {location['state']}, {location['country']}"
        data['post_code'] = location['postcode']
        data['email'] = user['email']
        data['username'] = user['login']['username']
        data['dob'] = user['dob']['date']
        data['registered_date'] = user['registered']['date']
        data['phone'] = user['phone']
        data['picture'] = user['picture']['medium']

        formatted_data.append(data)

    return formatted_data

# Call functions and store data in Dataframe format
df = pd.DataFrame(format_data(get_data()))

# Select only the columns to be used, namely name, surname, and gender
df = df.loc[:, ['first_name', 'last_name', 'gender']]


##### 2 
# Create an API call function to predict gender from the names stored in the data framework No.1.It calls data for predicting gender and probability
def api_predict(first_name):
    res = requests.get(f"https://api.genderize.io?name={first_name}").json()
    return res.get('gender'),res.get('probability')

# Create a column to store values. Gender from prediction and probability values By predicting from 'first_name' 
df[['gender(predict)', 'probability']] = df['first_name'].apply(api_predict).apply(pd.Series)

# Rename column 'gender' to 'gender(actual)'
df.rename(columns = {'gender' : 'gender(actual)'}, inplace = True)


##### 3
# Create a column to verify the presence of gender in predictions by returning the value to true instead of false
df['same_gender'] = np.where(df['gender(actual)'] == df['gender(predict)'], True, False)
df