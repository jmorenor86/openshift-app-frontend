"use client";

import { useMessage } from "../api/useMessage";

const MessageDisplay = () => {
  const { data, isLoading, error } = useMessage();

  if (isLoading) return <p>Loading...</p>;
  if (error) return <p>Error loading message: {error.message}</p>;

  const message = typeof data === "string" ? data : data?.message;

  return <h1>{message || "No message received"}</h1>;
};

export default MessageDisplay;
