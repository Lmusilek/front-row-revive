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
            messagesContainer.insertAdjacentHTML("beforeend", data);
            if (e.key === "Enter") {
              message.value = "";
              messagesContainer.scrollTop =
                messagesContainer.scrollHeight - messagesContainer.clientHeight;
            }
          });
        },
      }
    );
  }
};

export { initChatroomCable };
