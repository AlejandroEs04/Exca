import { isAxiosError } from "axios";
import api from "../lib/axios";
import { City } from "../types";

// Obtener todas las ciudades
export async function getCities() {
  try {
    const { data } = await api.get<City[]>("/cities");
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Obtener ciudad por ID
export async function getCityById(id: number) {
  try {
    const { data } = await api.get<City>(`/cities/${id}`);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Crear una nueva ciudad
export async function createCity(city: Omit<City, "id">) {
  try {
    const { data } = await api.post<City>("/cities", city);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Actualizar una ciudad existente
export async function updateCity(city: City) {
  try {
    const { data } = await api.put<City>(`/cities/${city.id}`, city);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Eliminar una ciudad
export async function deleteCity(id: number) {
  try {
    await api.delete(`/cities/${id}`);
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}
