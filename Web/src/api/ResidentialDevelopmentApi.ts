import { isAxiosError } from "axios";
import api from "../lib/axios";
import { ResidentialDevelopment, ResidentialDevelopmentCreate } from "../types";

// Obtener todos los desarrollos residenciales
export async function getResidentialDevelopments() {
  try {
    const { data } = await api.get<ResidentialDevelopment[]>("/residential-developments");
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Obtener un desarrollo residencial por ID
export async function getResidentialDevelopmentById(id: number) {
  try {
    const { data } = await api.get<ResidentialDevelopment>(`/residential-developments/${id}`);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Registrar un nuevo desarrollo
export async function createResidentialDevelopment(rd: ResidentialDevelopmentCreate) {
  try {
    const { data } = await api.post<ResidentialDevelopment>("/residential-developments", rd);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Actualizar un desarrollo existente
export async function updateResidentialDevelopment(rd: ResidentialDevelopment) {
  try {
    const { data } = await api.put<ResidentialDevelopment>(`/residential-developments/${rd.id}`, rd);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Eliminar un desarrollo
export async function deleteResidentialDevelopment(id: number) {
  try {
    await api.delete(`/residential-developments/${id}`);
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}
