import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from datetime import datetime


class FitnessTracker:
    def __init__(self):
        self.data=pd.DataFrame(columns=["date","activity type","duration","calories burned"])

    def log_activity(self, activity_type, duration, calories):
    
        if duration < 0 or calories < 0:
            if duration < 0:
                print("Duration cannot be negative")
            if calories < 0:
                print("Calories burned cannot be negative")
            return

        current = datetime.now().strftime("%Y-%m-%d")

        new = {
            "date": current,
            "activity type": activity_type,
            "duration": duration,
            "calories burned": calories
        }

        filename = "exam/fitness_tracker.csv"

        self.data = pd.read_csv(filename)
        self.data = pd.concat(
            [self.data, pd.DataFrame([new])],
            ignore_index=True
        )
        self.data.to_csv(filename, index=False)

        print("Activity logged successfully!")

    def calculate_metrics(self):
        total_calories=self.data["calories burned"].sum()
        avg_duration=self.data["duration"].mean()
        activity_frequency=self.data["activity type"].value_counts()


        print("Total Calories Burned:",total_calories)
        print("Average Duration:",avg_duration)
        print("Activity Frequency",activity_frequency)

    def filter_activities(self,condition):
        if isinstance(condition,str):
            filtered=self.data[self.data["activity type"]==condition]
        elif isinstance(condition,tuple):
            start,end=condition
            filtered=self.data[(self.data["date"]>start) and(self.data["date"]<end)]
        
        print(filtered)


    def generate_report(self):
        print(self.data)


    def load_data(self):
        filename="exam/fitness_tracker.csv"
        self.data=pd.read_csv(filename)
        print("Data loaded")


    def analyze(self):
        avg_duration=np.mean(self.data["duration"])
        avg_calories=np.mean(self.data["calories"])

        
        print("Average Duration:",avg_duration)
        print("Average Calories:",avg_calories)
        print("Total time per activity",self.data.groupby("activity type")["duration"].sum())

    def visualize(self):
        #bar chart
        plt.figure(figsize=(6,8))
        self.data.groupby("activity type")["duration"].sum().plot(kind="bar")
        plt.title("Time spent on Activities")
        plt.ylabel("Time(in minutes)")    
        plt.show()

        #line chart
        plt.figure(figsize=(6,8))
        plt.bar(self.data["date"],self.data["calories burned"])
        plt.title("Calories burned per day")
        plt.xlabel("Date")
        plt.ylabel("calories burned(in kcal)")
        plt.title("Calories burned over time")
        plt.xticks(rotation=45)
        plt.show()

        #pie chart
        plt.figure(figsize=(6,8))
        self.data.groupby("activity type")["duration"].sum().plot(kind="pie",autopct="%1.1f%%")
        plt.title("Activity Distribution")
        plt.show()

        #heat map
        plt.figure(figsize=(6,8))
        sns.heatmap(self.data[["duration","calories"]].corr)
        plt.title("HeatMap Correlation")
        plt.show()

Object=FitnessTracker()
Object.log_activity("Running",30,300)
Object.log_activity("Swimming",45,310)
Object.load_data()
Object.calculate_metrics()
Object.filter_activities("Running")
Object.generate_report()
