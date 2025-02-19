import apiClient from "./apiClient";

export const getMessage = async (): Promise<{ message: string }> => {
  const response = await apiClient.get("/hello");
  return response.data;
};
