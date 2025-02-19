import { useQuery } from "@tanstack/react-query";
import { getMessage } from "./messageService";

export const useMessage = () => {
  return useQuery({
    queryKey: ["message"],
    queryFn: getMessage,
    staleTime: 1000 * 60 * 5,
    refetchOnWindowFocus: false, 
    retry: 1,
  });
};
