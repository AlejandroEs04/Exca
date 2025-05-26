import { isAxiosError } from "axios";
import api from "../lib/axios";
import { LandStatus } from "../types";

// Obtener todos los estatus de terrenos
export async function getLandStatuses() {
  try {
    const { data } = await api.get<LandStatus[]>("/land-statuses");
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Obtener un estatus por ID
export async function getLandStatusById(id: number) {
  try {
    const { data } = await api.get<LandStatus>(`/land-statuses/${id}`);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Crear nuevo estatus
export async function createLandStatus(status: Omit<LandStatus, "id">) {
  try {
    const { data } = await api.post<LandStatus>("/land-statuses", status);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Actualizar estatus existente
export async function updateLandStatus(status: LandStatus) {
  try {
    const { data } = await api.put<LandStatus>(`/land-statuses/${status.id}`, status);
    return data;
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}

// Eliminar estatus
export async function deleteLandStatus(id: number) {
  try {
    await api.delete(`/land-statuses/${id}`);
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error(error.response.data.detail || error.message);
    }
  }
}
