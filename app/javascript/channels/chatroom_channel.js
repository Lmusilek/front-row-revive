import consumer from "./consumer";
const message = document.getElementById("livechat-input");

const initChatroomCable = () => {
  const messagesContainer = document.getElementById("messages");
  // When entering Room chat goes straight to bottom

  if (messagesContainer) {
    messagesContainer.scrollTop =
      messagesContainer.scrollHeight - messagesContainer.clientHeight;
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create(
      { channel: "ChatroomChannel", id: id },
      {
        received(data) {
          console.log(data); // called when data is broadcast in the cable
          message.addEventListener("keyup", function (e) {
            if (e.key === "Enter") {
              messagesContainer.insertAdjacentHTML("beforeend", data);
              message.value = "";
              messagesContainer.scrollTop =
                messagesContainer.scrollHeight - messagesContainer.clientHeight;
            }
          });
        },
      }
    );
  }

  // Entering Messages Function On keyup("Enter") removes input text and scrollchat
};

export { initChatroomCable };
