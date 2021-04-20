import consumer from "./consumer";
const message = document.getElementById("livechat-input");

const initChatroomCable = () => {
  const messagesContainer = document.getElementById("messages");
  // When entering Room chat goes straight to bottom
  messagesContainer.scrollTop =
    messagesContainer.scrollHeight - messagesContainer.clientHeight;

  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create(
      { channel: "ChatroomChannel", id: id },
      {
        received(data) {
          console.log(data); // called when data is broadcast in the cable
          messagesContainer.insertAdjacentHTML("beforeend", data);
        },
      }
    );
  }

  // Entering Messages Function On keyup("Enter") removes input text and scrollchat

  message.addEventListener("keyup", function (e) {
    if (e.key === "Enter") {
      message.value = "";
      messagesContainer.scrollTop =
        messagesContainer.scrollHeight - messagesContainer.clientHeight;
    }
  });
};

export { initChatroomCable };
