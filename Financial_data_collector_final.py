
# coding: utf-8

# In[ ]:

import pandas as pd
from urllib.request import urlopen
import io

import os.path
from functools import reduce
import pandas as pd

def collect_data(company):  #fix to handle errors if link inactive
    ticker = company
    link_income_statement ='https://stockrow.com/api/companies/'+ticker +'/financials.xlsx?dimension=MRQ&section=Income%20Statement'
    link_balance_sheet = 'https://stockrow.com/api/companies/'+ticker +'/financials.xlsx?dimension=MRQ&section=Balance%20Sheet'
    link_cash_flow ='https://stockrow.com/api/companies/'+ticker +'/financials.xlsx?dimension=MRQ&section=Cash%20Flow'
    link_metrices = 'https://stockrow.com/api/companies/'+ticker +'/financials.xlsx?dimension=MRQ&section=Metrics'
    link_growth = 'https://stockrow.com/api/companies/'+ticker +'/financials.xlsx?dimension=MRQ&section=Growth'



    socket_income_statement = urlopen(link_income_statement)
    socket_balance_sheet = urlopen(link_balance_sheet)
    socket_cash_flow = urlopen(link_cash_flow)
    socket_metrices =  urlopen(link_metrices)
    socket_growth = urlopen(link_growth)

    xl_income_statement  = pd.ExcelFile(socket_income_statement)
    xl_balance_sheet = pd.ExcelFile(socket_balance_sheet)
    xl_cash_flow = pd.ExcelFile(socket_cash_flow)
    xl_metrices = pd.ExcelFile(socket_metrices)
    xl_growth = pd.ExcelFile(socket_growth)


    df_income_statement  = xl_income_statement.parse(sheet_name=ticker, header=None)
    df_balance_sheet = xl_balance_sheet.parse(sheet_name=ticker, header=None)
    df_cash_flow = xl_cash_flow.parse(sheet_name=ticker, header=None)
    df_metrices = xl_metrices.parse(sheet_name=ticker, header=None)
    df_growth =xl_growth.parse(sheet_name=ticker, header=None)

    path ='/eccs/users/nbhand14/Econ_488_Data/'
    file_name = path+ticker+'.xlsx'
    writer = pd.ExcelWriter(file_name, engine='xlsxwriter')



    df_income_statement.to_excel(writer, sheet_name='income_statement')
    df_balance_sheet.to_excel(writer, sheet_name='balance_sheet')
    df_cash_flow.to_excel(writer, sheet_name='cash_flow')
    df_metrices.to_excel(writer, sheet_name='metrices')
    df_growth.to_excel(writer, sheet_name='growth')

    writer.save()
    print("Compiled Data for : ", ticker)
    

list_companies =[
 'YUM',
 'ZBH',
 'ZION',
 'ZTS']

for company in list_companies: 
    collect_data(company)   
    
    
#df= pd.read_csv('constituents_csv.csv')  ##get from https://datahub.io/core/s-and-p-500-companies
#symbols = df.Symbol
#list_companies = []
#for m in symbols:
    #list_companies.append(m)
    
    


df_r = pd.read_csv('constituents_csv.csv')   #get from https://datahub.io/core/s-and-p-500-companies
data_master=pd.DataFrame()

for index, row in df_r.iterrows():
    ticker = row['Symbol']
    sector = row['Sector'] 
    name = row['Name']
    
    path ='/eccs/users/nbhand14/Econ_488_Data/'
    file = path+ticker+'.xlsx'
    
    if os.path.isfile(file):
        print("TIICKER there :", ticker)
        df_income_statement = pd.read_excel(file, sheet_name='income_statement')
        df_balance_sheet = pd.read_excel(file, sheet_name= 'balance_sheet') 
        df_cash_flow= pd.read_excel(file, sheet_name = 'cash_flow')
        df_metrices = pd.read_excel(file, sheet_name = 'metrices')
        df_growth = pd.read_excel(file, sheet_name = 'growth')



        df = df_income_statement
        df = df.T    #transpose data frame. 
        df.iloc[0,0] = 'Dates'
        new_header = df.iloc[0]
        df.columns = new_header
        df =  df[1:]
        df.set_index(df.Dates,inplace = True)
        df_1 = df 

        df = df_balance_sheet 
        df = df.T    #transpose data frame. 
        df.iloc[0,0] = 'Dates'
        new_header = df.iloc[0]
        df.columns = new_header
        df =  df[1:]
        df.set_index(df.Dates,inplace = True)
        df_2 =df 


        df = df_cash_flow
        df = df.T    #transpose data frame. 
        df.iloc[0,0] = 'Dates'
        new_header = df.iloc[0]
        df.columns = new_header
        df =  df[1:]
        df.set_index(df.Dates,inplace = True)
        df_3 =df


        df = df_metrices
        df = df.T    #transpose data frame. 
        df.iloc[0,0] = 'Dates'
        new_header = df.iloc[0]
        df.columns = new_header
        df =  df[1:]
        df.set_index(df.Dates,inplace = True)
        df_4 =df



        df = df_growth
        df = df.T    #transpose data frame. 
        df.iloc[0,0] = 'Dates'
        new_header = df.iloc[0]
        df.columns = new_header
        df =  df[1:]
        df.set_index(df.Dates,inplace = True)
        df_5 =df


        dfs = [df_1, df_2, df_3,df_4,df_5] 

        df_final = reduce(lambda left,right: pd.merge(left,right,on='Dates'), dfs)
        df_final.insert(1, 'TICKER', ticker)
        df_final.insert(2, 'NAME', name)
        df_final.insert(3, 'SECTOR', sector)
        #df_final['1TICKER'] = ticker
        #df_final['2NAME'] = name
        #df_final['3SECTOR'] = sector
        #df_final.rename(columns={'Dates': '4DATES'}, inplace=True)
        #df_final.reindex(sorted(df_final.columns), axis=1)
        data_master=data_master.append(df_final,ignore_index=True)
        #appended_data.append(df_final)        
        
        
    else: 
        print("ticket not present :", ticker)
        
#df_master = pd.concat(appended_data, axis=1)

data_master.to_excel('TEST_Master_500.xlsx')
        

