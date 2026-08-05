import tkinter as tk
from tkinter import scrolledtext
import json

from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

#  LOAD FAQ 

with open("faq.json", "r", encoding="utf-8") as file:
    data = json.load(file)

questions = [item["question"] for item in data["faqs"]]
answers = [item["answer"] for item in data["faqs"]]

#  AI ENGINE 

vectorizer = TfidfVectorizer()

question_vectors = vectorizer.fit_transform(questions)


def get_response(user_input):
    user_input = user_input.lower().strip()

    user_vector = vectorizer.transform([user_input])

    similarity = cosine_similarity(user_vector, question_vectors)

    best_match = similarity.argmax()

    score = similarity[0][best_match]

    print("Question:", user_input)
    print("Best Match:", questions[best_match])
    print("Score:", score)

    if score >= 0.40:
        return answers[best_match]
    else:
        return "Sorry, I don't know the answer to that question."


#  SEND MESSAGE 

def send_message():
    user_input = entry.get().strip()

    if user_input == "":
        return

    response = get_response(user_input)

    chat_area.config(state="normal")

    chat_area.insert(tk.END, "You: " + user_input + "\n", "user")
    chat_area.insert(tk.END, "Bot: " + response + "\n\n", "bot")

    chat_area.config(state="disabled")

    chat_area.see(tk.END)

    entry.delete(0, tk.END)


#  CLEAR CHAT 

def clear_chat():
    chat_area.config(state="normal")
    chat_area.delete("1.0", tk.END)
    chat_area.config(state="disabled")


#  WINDOW 

root = tk.Tk()

root.title("AI FAQ Chatbot")

root.geometry("700x600")

root.configure(bg="#f4f6f9")

#  TITLE 

title = tk.Label(
    root,
    text="🤖 AI FAQ Chatbot",
    font=("Arial", 22, "bold"),
    bg="#f4f6f9",
    fg="#2c3e50"
)

title.pack(pady=15)

#  CHAT AREA 

chat_area = scrolledtext.ScrolledText(
    root,
    width=75,
    height=20,
    font=("Arial", 11),
    state="disabled"
)

chat_area.pack(padx=10, pady=10)

chat_area.tag_config("user", foreground="blue")
chat_area.tag_config("bot", foreground="green")

#  INPUT FRAME 

input_frame = tk.Frame(root, bg="#f4f6f9")
input_frame.pack(pady=10)

entry = tk.Entry(
    input_frame,
    width=50,
    font=("Arial", 12)
)
entry.grid(row=0, column=0, padx=5)


send_btn = tk.Button(
    input_frame,
    text="Send",
    command=send_message,
    bg="#3498db",
    fg="white",
    font=("Arial", 11, "bold"),
    width=10
)
send_btn.grid(row=0, column=1, padx=5)


clear_btn = tk.Button(
    input_frame,
    text="Clear",
    command=clear_chat,
    bg="#e74c3c",
    fg="white",
    font=("Arial", 11, "bold"),
    width=10
)
clear_btn.grid(row=0, column=2, padx=5)

# Press Enter to Send
entry.bind("<Return>", lambda event: send_message())

#  WELCOME MESSAGE 

chat_area.config(state="normal")

chat_area.insert(
    tk.END,
    "🤖 Bot: Hello! Welcome to the AI FAQ Chatbot.\n"
    "Ask me questions like:\n"
    "- What is Python?\n"
    "- What is AI?\n"
    "- What is Machine Learning?\n\n",
    "bot"
)

chat_area.config(state="disabled")

#  RUN APPLICATION 

root.mainloop()
