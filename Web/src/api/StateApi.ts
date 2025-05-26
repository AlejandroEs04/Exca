import { isAxiosError } from "axios";
import api from "../lib/axios";
import { State } from "../types";

// Obtener todos los estados
export async function getStates() {
  try {
    const { data } = await api.get<State[]>("/states");
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Obtener estado por ID
export async function getStateById(id: number) {
  try {
    const { data } = await api.get<State>(`/states/${id}`);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Crear un nuevo estado
export async function createState(state: Omit<State, "id">) {
  try {
    const { data } = await api.post<State>("/states", state);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Actualizar estado existente
export async function updateState(state: State) {
  try {
    const { data } = await api.put<State>(`/states/${state.id}`, state);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Eliminar un estado
export async function deleteState(id: number) {
  try {
    await api.delete(`/states/${id}`);
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}
